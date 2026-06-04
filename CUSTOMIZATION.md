# 커스터마이징 가이드

이 문서는 AI Interactive Onboarding Template을 자사 환경에 맞게 바꾸는 방법을 안내합니다.

핵심 전제:
- 이 템플릿은 현재 가상 회사 **TeamSpace Inc. / Collabo / Dana** 데이터로 채워져 있습니다.
- 공용 읽기 콘텐츠는 `content/` 로컬 사본을 사용합니다.
- Notion은 콘텐츠 편집 원본이자 칸반/개인 산출물 저장소입니다.
- Notion 콘텐츠를 고친 뒤에는 Claude Code에서 `/sync-content`를 실행해 `content/`를 갱신합니다.

---

## 1. 필수 설정 파일

먼저 예시 파일을 실제 설정 파일로 복사합니다.

```bash
cp config/notion-ids.example.json config/notion-ids.json
cp config/team-leads.example.json config/team-leads.json
```

`config/notion-ids.json`과 `config/team-leads.json`은 `.gitignore`에 포함되어 있어 실수로 커밋되지 않습니다.

### config/notion-ids.json

자사 Notion에 온보딩 페이지/DB를 만든 뒤 각 ID를 입력합니다.

```json
{
  "onboarding_parent": "온보딩 메인 페이지 ID",
  "onboarding_db": "온보딩 진행 상황 추적 DB ID",
  "step1_general": "Step 1 General Onboarding 페이지 ID",
  "step2_product": "Step 2 Product Onboarding 페이지 ID",
  "step3_biz": "Step 3 Biz Onboarding 페이지 ID",
  "step6_live_audit": "Step 6 실서비스 참관 페이지 ID",
  "github_guide": "GitHub 가이드 페이지 ID",
  "culture_deck": "컬쳐덱/회사소개 페이지 ID"
}
```

Notion 페이지 ID는 페이지 URL의 마지막 32자리 문자열입니다.
예: `https://www.notion.so/My-Page-abcdef1234567890abcdef1234567890` → `abcdef1234567890abcdef1234567890`

### config/team-leads.json

자사 조직 구조와 연결 담당자를 입력합니다.

- 팀/셀 이름
- 각 리더의 닉네임, 역할, Slack ID
- `cell_to_team` 매핑
- `step_domain_owners`: Step 2(제품), Step 3(사업) 담당자

---

## 2. 회사 정보 일괄 치환

템플릿에 들어 있는 가상 회사 정보를 자사 정보로 바꿉니다.

| 현재 값 | 의미 | 교체 예시 |
|---|---|---|
| `TeamSpace Inc.` / `팀스페이스` | 회사명 | ABC Corp / 에이비씨 |
| `Collabo` / `콜라보` | 서비스명 | MyService |
| `teamspace.io` | 회사 이메일 도메인 | abc-corp.com |
| `Dana` / `이다나` | HR Lead | Jane / 김제인 |
| `teamspace-ai-all` | GitHub Organization | abc-corp-ai |
| `#00-teamspace-announcements` 등 | Slack 채널 | 자사 채널명 |
| `admin.collabo.io` | 관리자/백오피스 URL | 자사 백오피스 URL |
| `워크스페이스 오너` / `멤버` | 제품 사용자 페르소나 | 자사 제품 페르소나 |
| `Enterprise 온보딩 세션 참관` | Step 6 참관 대상 | 고객 콜, 수업, 상담, 현장 방문 등 |

macOS 기준 예시:

```bash
COMPANY_KO="에이비씨"
COMPANY_EN="ABC Corp"
SERVICE_KO="마이서비스"
SERVICE_EN="MyService"
DOMAIN="abc-corp.com"
HR_LEAD="Jane"
GITHUB_ORG="abc-corp-ai"

find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" \) \
  ! -path "./.git/*" \
  ! -path "./config/notion-ids.json" \
  ! -path "./config/team-leads.json" \
  -exec sed -i '' \
    -e "s/팀스페이스/$COMPANY_KO/g" \
    -e "s/TeamSpace Inc./$COMPANY_EN/g" \
    -e "s/콜라보/$SERVICE_KO/g" \
    -e "s/Collabo/$SERVICE_EN/g" \
    -e "s/teamspace.io/$DOMAIN/g" \
    -e "s/Dana/$HR_LEAD/g" \
    -e "s/teamspace-ai-all/$GITHUB_ORG/g" \
    {} +
```

Linux는 `sed -i ''` 대신 `sed -i`를 사용합니다.

확인:

```bash
# 가상 회사 정보가 남아있는지 확인
grep -R "TeamSpace\|팀스페이스\|Collabo\|콜라보\|teamspace.io\|Dana\|teamspace-ai-all" \
  --include="*.md" --include="*.json" . \
  | grep -v ".git/"
```

---

## 3. content/ 로컬 콘텐츠 갱신

최신 버전은 신규입사자 세션 중 공용 콘텐츠를 Notion에서 매번 fetch하지 않습니다. 대신 `content/` 로컬 사본을 읽습니다.

### 갱신 흐름

```text
Notion에서 콘텐츠 편집
  ↓
Claude Code에서 /sync-content 실행
  ↓
content/*.md 갱신
  ↓
git commit
  ↓
신규입사자 세션은 content/를 즉시 Read
```

### 동기화 대상

| Notion 키 | 로컬 파일 | 용도 |
|---|---|---|
| `step1_general` | `content/step1-general.md` | 회사 문화/도구/일반 온보딩 |
| `step2_product` | `content/step2-product-guide.md` | 제품 체험 가이드 |
| `step3_biz` | `content/step3-biz.md` | BM/고객 여정 |
| `step6_live_audit` | `content/step6-live-audit.md` | 참관 가이드 |
| `github_guide` | `content/github-guide.md` | GitHub 사용 가이드 |

실행:

```text
/sync-content
```

특정 키만 갱신:

```text
/sync-content step3_biz
```

주의:
- `content/`는 파생물입니다. 가능하면 Notion 원본을 수정한 뒤 `/sync-content`로 갱신하세요.
- fetch 실패 시 기존 로컬 사본은 덮어쓰지 않습니다.
- 칸반, 개밥먹기 문서, AI 개선안처럼 신규입사자별로 생성되는 개인 페이지는 `content/`로 옮기지 않습니다.

---

## 4. 파일별 커스터마이징 포인트

### 루트 문서

| 파일 | 작업 |
|---|---|
| `README.md` | 공개 소개, 회사 설정 표, Getting Started 수정 |
| `CLAUDE.md` | 프로젝트 규칙, 회사명, 도메인, GitHub org, Step 설명 수정 |
| `CUSTOMIZATION.md` | 자사 운영 방식에 맞게 가이드 보정 |

### Step 0 — Setup

| 파일 | 작업 |
|---|---|
| `.claude/skills/step0-setup/SKILL.md` | Phase 구성 조정 |
| `.claude/skills/step0-setup/references/phase1-mcp-connect.md` | 연결할 MCP 서비스 수정 |
| `.claude/skills/step0-setup/references/phase2-claude-tips.md` | 자사 Claude 사용 팁 추가 |
| `.claude/skills/step0-setup/references/phase3-settings-optimization.md` | 설정/Output Style 안내 수정 |
| `.claude/skills/step0-setup/references/phase4-github-leaderboard.md` | 리더보드 미운영 시 제거/비활성화 |

각 Phase의 CHECK가 별도 파일로 분리되어 있으면 `{phase}-check.md`도 함께 수정합니다.

### Step 1 — General

| 파일 | 작업 |
|---|---|
| `content/step1-general.md` | 회사 문화, 수습평가, 도구, 첫 주 체크리스트 |
| `.claude/skills/step1-general/references/culture-deck.md` | 요약형 컬쳐덱 |
| `.claude/skills/step1-general/references/phase1-culture.md` | 문화 소개 흐름 |
| `.claude/skills/step1-general/references/phase2-tools.md` | 업무 도구 세팅 흐름 |
| `.claude/skills/step1-general/references/phase3-checklist.md` | Slack 인사/체크리스트 흐름 |

### Step 2 — Product

| 파일 | 작업 |
|---|---|
| `content/step2-product-guide.md` | 제품 체험 가이드 |
| `.claude/skills/step2-product/references/phase0-product-team.md` | 제품 조직 소개 |
| `.claude/skills/step2-product/references/phase1-experience.md` | 제품 체험 진행 방식 |
| `.claude/skills/step2-product/references/phase2-report.md` | AI 개선안/리포트 작성 흐름 |
| `templates/step2-product-report.md` | 제품 체험 리포트 템플릿 |

### Step 3 — Biz

| 파일 | 작업 |
|---|---|
| `content/step3-biz.md` | BM, 고객 여정, 핵심 지표 |
| `.claude/skills/step3-biz/references/phase0-biz-team.md` | 사업/Growth 조직 소개 |
| `.claude/skills/step3-biz/references/phase1-bm.md` | BM 설명 흐름 |
| `.claude/skills/step3-biz/references/phase2-customer.md` | 고객 여정 설명 |
| `.claude/skills/step3-biz/references/phase2-scenarios-*.md` | 직무별 시나리오 퀴즈 |
| `.claude/skills/step3-biz/references/phase3-team-deep-dive.md` | 팀별 심화 |
| `templates/step3-biz-report.md` | BM 리포트 템플릿 |

시나리오/퀴즈 파일은 **본문 + 질문 + 선택지**가 모두 일반 메시지로 출력되도록 작성해야 합니다. AskUserQuestion 위젯으로 시나리오 본문을 대체하지 마세요.

### Step 4 — Build Your First Skill

| 파일 | 작업 |
|---|---|
| `.claude/skills/step4-skill/SKILL.md` | GitHub org/PR 운영 방식 |
| `.claude/skills/step4-skill/references/phase1-skill-anatomy.md` | 스킬 해부 설명 |
| `.claude/skills/step4-skill/references/phase2-design.md` | 스킬 설계 워크시트 |
| `.claude/skills/step4-skill/references/phase3-implementation.md` | 구현/PR 안내 |
| `content/github-guide.md` | GitHub 사용 가이드 |

### Step 5 — Wrap Up

| 파일 | 작업 |
|---|---|
| `.claude/skills/step5-wrapup/SKILL.md` | 회고/마무리 규칙 |
| `.claude/skills/step5-wrapup/references/phase1-retrospective.md` | 회고 질문 |
| `.claude/skills/step5-wrapup/references/phase2-action-plan.md` | 첫 주 실행계획 |
| `.claude/skills/step5-wrapup/references/phase3-feedback.md` | 피드백 수집 |

### Step 6 — Live Audit

| 파일 | 작업 |
|---|---|
| `content/step6-live-audit.md` | 참관 가이드 |
| `.claude/skills/step6-live-audit/SKILL.md` | Step 6 운영 방식 |
| `.claude/skills/step6-live-audit/references/phase1-preparation.md` | 참관 준비 |
| `.claude/skills/step6-live-audit/references/phase2-report.md` | 참관 리포트 |

자사 서비스 특성에 맞게 “Enterprise 온보딩 세션 참관”을 고객콜, 영업 미팅, 수업 참관, CS 티켓 분석 등으로 바꾸면 됩니다.

---

## 5. 운영 전 검증 체크리스트

- [ ] `config/notion-ids.json`에 실제 Notion ID 입력
- [ ] `config/team-leads.json`에 실제 팀/리더/Slack ID 입력
- [ ] 회사명/서비스명/도메인/GitHub org 치환 완료
- [ ] `content/*.md`를 `/sync-content`로 갱신
- [ ] `grep -R "TeamSpace\|팀스페이스\|Collabo\|콜라보\|teamspace.io\|Dana"` 결과 확인
- [ ] 각 Step의 `{phase}.md`와 `{phase}-check.md` 쌍 수정 여부 확인
- [ ] 시나리오 퀴즈가 AskUserQuestion이 아닌 plain text 출력 규칙을 따르는지 확인
- [ ] `/onboarding` 테스트 실행
- [ ] 신규입사자에게 전달할 설치/접속 안내 준비

---

## 6. 원본 동기화 스크립트

이 레포는 운영 원본 레포의 최신 구조를 템플릿에 반영하기 위한 `scripts/sync-from-source.sh`를 포함합니다.

```bash
cp scripts/.env.example scripts/.env.local
# SOURCE_REPO=/path/to/source-onboarding 으로 설정
./scripts/sync-from-source.sh --dry-run
./scripts/sync-from-source.sh
```

주의:
- `--dry-run`으로 변경 범위를 먼저 확인하세요.
- `README.md`, `CUSTOMIZATION.md`, `LICENSE`, `scripts/`, `config/*.example.json`은 템플릿 고유 파일이라 보존됩니다.
- 동기화 후 회사명 잔여 스캔과 `git diff` 검토를 반드시 수행하세요.
