# 커스터마이징 가이드

이 문서는 온보딩 템플릿을 자사 환경에 맞게 커스터마이징하는 방법을 안내합니다.

---

## 목차

1. [플레이스홀더 일괄 치환](#1-플레이스홀더-일괄-치환)
2. [파일별 커스터마이징 가이드](#2-파일별-커스터마이징-가이드)
3. [사전 학습 노션 페이지 세팅](#3-사전-학습-노션-페이지-세팅)
4. [sed 일괄 치환 명령어](#4-sed-일괄-치환-명령어)
5. [선택적 커스터마이징](#5-선택적-커스터마이징)

---

## 1. 플레이스홀더 일괄 치환

템플릿 전체에서 `{{PLACEHOLDER}}` 형태의 값을 자사 정보로 교체해야 합니다.

| 플레이스홀더 | 설명 | 예시 |
|---|---|---|
| `{{COMPANY_NAME}}` | 회사명 | 에이비씨 주식회사 |
| `{{COMPANY_NAME_EN}}` | 회사 영문명 | ABC Corp |
| `{{SERVICE_NAME}}` | 서비스/제품명 | MyService |
| `{{COMPANY_DOMAIN}}` | 이메일 도메인 | abc-corp.com |
| `{{HR_LEAD}}` | HR 담당자 닉네임 | Jane |
| `{{HR_LEAD_SLACK_ID}}` | HR 담당자 Slack ID | U01ABCD2EFG |
| `{{CEO_NAME}}` | 대표 이름/닉네임 | Alex |
| `{{CPO_NAME}}` | CPO 이름/닉네임 (없으면 제품 책임자) | Chris |
| `{{CBO_NAME}}` | CBO 이름/닉네임 (없으면 사업 책임자) | Morgan |
| `{{GITHUB_ORG}}` | GitHub Organization 이름 | abc-corp |
| `{{HR_SYSTEM}}` | 인사관리 시스템 | Flex, HRIS, Workday 등 |
| `{{OFFICE_APP}}` | 사무실/공유오피스 앱 | 헤이그라운드, WeWork 등 |
| `{{PASSWORD_MANAGER}}` | 비밀번호 관리 도구 | 1Password, Bitwarden 등 |
| `{{LEADERBOARD_URL}}` | 사내 Claude Code 리더보드 URL | https://leaderboard.abc-corp.com |

> **참고**: `{{LEADERBOARD_URL}}`은 사내 리더보드를 운영하지 않는 경우 Step 0의 Phase 4(리더보드)를 제거하면 됩니다.

---

## 2. 파일별 커스터마이징 가이드

### 우선순위 1: 필수 설정 파일

반드시 자사 정보로 교체해야 온보딩이 동작합니다.

| 파일 | 설명 | 작업 내용 |
|---|---|---|
| `CLAUDE.md` | 프로젝트 루트 설정 | 플레이스홀더 치환 (자동 sed로 처리 가능) |
| `config/notion-ids.json` | Notion 페이지 ID 매핑 | 자사 Notion 페이지 ID로 교체 |
| `config/team-leads.json` | 조직 구조 및 리더 정보 | 자사 팀/셀/리더 정보 입력 |

#### config/notion-ids.json

온보딩 각 Step에서 Notion MCP로 콘텐츠를 동적 참조합니다. 자사 Notion에 온보딩 페이지를 만든 뒤, 각 페이지 ID를 입력하세요.

```json
{
  "onboarding_parent": "온보딩 메인 페이지 ID",
  "step1_general": "Step 1 General Onboarding 페이지 ID",
  "step2_product": "Step 2 Product Onboarding 페이지 ID",
  "step3_biz": "Step 3 Biz Onboarding 페이지 ID",
  "step6_live_audit": "Step 6 실서비스 참관 페이지 ID",
  "onboarding_db": "온보딩 진행 상황 추적 DB ID",
  "general_home": "사내 일반 정보 홈 페이지 ID",
  "culture_deck": "컬쳐덱 페이지 ID"
}
```

> Notion 페이지 ID는 페이지 URL의 마지막 32자리 문자열입니다.
> 예: `https://www.notion.so/My-Page-abcdef1234567890abcdef1234567890` → `abcdef1234567890abcdef1234567890`

#### config/team-leads.json

자사 조직 구조를 반영합니다. `config/team-leads.example.json`을 참고하여 작성하세요.

- 팀/셀 이름을 자사에 맞게 변경
- 각 리더의 닉네임, 역할, Slack ID 입력
- `cell_to_team` 매핑 업데이트
- `step_domain_owners`에 Step 2(제품), Step 3(사업) 담당자 지정

---

### 우선순위 2: 콘텐츠 파일

자사의 실제 정보를 채워야 온보딩 품질이 올라갑니다.

| 파일 | Step | 설명 | 작업 내용 |
|---|---|---|---|
| `.claude/skills/step1-general/references/culture-deck.md` | Step 1 | 컬쳐덱 요약 | 자사 미션, 비전, 핵심가치, 일하는 방식 등 작성 |
| `.claude/skills/step1-general/references/ir-deck-summary.md` | Step 1 | IR 자료 요약 | 자사 IR 덱 또는 회사 소개 요약 |
| `.claude/skills/step1-general/references/phase1-culture.md` | Step 1 | 조직문화 Phase 설명 | 자사 조직문화 소개 스크립트 |
| `.claude/skills/step1-general/references/phase2-tools.md` | Step 1 | 업무 도구 안내 | 자사에서 사용하는 도구(Slack, Notion, Google Workspace 등) 안내 |
| `.claude/skills/step1-general/references/phase3-checklist.md` | Step 1 | 체크리스트 | 입사 첫 주 체크리스트 항목 |
| `.claude/skills/step3-biz/references/phase1-bm.md` | Step 3 | BM(비즈니스 모델) | 자사 비즈니스 모델, 수익 구조, 핵심 지표 작성 |
| `.claude/skills/step3-biz/references/phase2-scenarios-*.md` | Step 3 | 직무별 시나리오 | 각 직무(영업, 제품, 개발, CX, 경영관리 등)의 업무 시나리오 |
| `.claude/skills/step3-biz/references/phase2-customer.md` | Step 3 | 고객 여정 | 자사 고객 여정 맵 |
| `.claude/skills/step3-biz/references/phase0-biz-team.md` | Step 3 | 사업팀 소개 | 사업팀 구성과 역할 |
| `.claude/skills/step2-product/references/phase0-product-team.md` | Step 2 | 제품팀 소개 | 제품팀 구성과 역할 |
| `.claude/skills/step2-product/references/phase1-experience.md` | Step 2 | 제품 체험 가이드 | 자사 제품/서비스 체험 시나리오 |

---

### 우선순위 3: Step 0 설치 가이드

| 파일 | 설명 | 작업 내용 |
|---|---|---|
| `.claude/skills/step0-setup/references/phase0-roadmap.md` | 온보딩 로드맵 | 자사에 맞게 Step 구성 조정 |
| `.claude/skills/step0-setup/references/phase1-mcp-connect.md` | MCP 연결 안내 | 사용하는 MCP 서비스에 맞게 수정 |
| `.claude/skills/step0-setup/references/phase2-claude-tips.md` | Claude 사용 팁 | 필요 시 자사 맥락 추가 |
| `.claude/skills/step0-setup/references/phase3-settings-optimization.md` | 설정 최적화 | 자사 워크플로우에 맞게 수정 |
| `.claude/skills/step0-setup/references/phase4-github-leaderboard.md` | 리더보드 안내 | 리더보드 미운영 시 이 Phase 제거 |
| `.claude/skills/step0-setup/references/claude-code-install-guide-for-notion.md` | Notion용 설치 가이드 | 아래 "사전 학습 노션 페이지" 섹션 참고 |

---

### 우선순위 4: 산출물 템플릿

| 파일 | 설명 |
|---|---|
| `templates/step1-checklist.md` | Step 1 체크리스트 템플릿 |
| `templates/step2-product-report.md` | Step 2 제품 리포트 템플릿 |
| `templates/step3-biz-report.md` | Step 3 BM 리포트 템플릿 |

이 템플릿들은 범용적으로 작성되어 있어 큰 수정 없이 사용 가능하지만, 자사 특성에 맞게 항목을 추가/제거할 수 있습니다.

---

## 3. 사전 학습 노션 페이지 세팅

온보딩은 Step 0부터 시작하지만, 그 전에 신규입사자가 Claude Code를 미리 설치해와야 합니다.

### 흐름

```
[입사 전/입사 당일]
  Notion 사전 학습 페이지에서 Claude Code 설치
    ↓
[온보딩 시작]
  터미널에서 /onboarding 실행 → Step 0부터 진행
```

### 세팅 방법

1. `.claude/skills/step0-setup/references/claude-code-install-guide-for-notion.md` 파일을 열어 자사 정보로 수정
   - HR 담당자 이름 변경
   - GitHub Organization 이름 변경
   - 필요 없는 도구(예: 공유오피스 앱) 제거 또는 추가
2. 수정한 내용을 사내 Notion에 새 페이지로 게시
3. 신규입사자에게 입사 전 또는 입사 당일 해당 Notion 페이지 링크를 공유

> 이 페이지는 Claude Code 설치, 구독 안내, 레포 클론, MCP 연결까지를 다루는 사전 학습 자료입니다.

---

## 4. sed 일괄 치환 명령어

프로젝트 루트에서 아래 명령어를 실행하면 모든 파일의 플레이스홀더를 한 번에 치환할 수 있습니다.

```bash
# 자사 정보로 변수 설정
COMPANY_NAME="에이비씨 주식회사"
COMPANY_NAME_EN="ABC Corp"
SERVICE_NAME="MyService"
COMPANY_DOMAIN="abc-corp.com"
HR_LEAD="Jane"
HR_LEAD_SLACK_ID="U01ABCD2EFG"
CEO_NAME="Alex"
CPO_NAME="Chris"
CBO_NAME="Morgan"
GITHUB_ORG="abc-corp"
HR_SYSTEM="Flex"
OFFICE_APP="위워크"
PASSWORD_MANAGER="1Password"
LEADERBOARD_URL="https://leaderboard.abc-corp.com"

# 일괄 치환 실행 (macOS sed 기준)
find . -type f \( -name "*.md" -o -name "*.json" \) \
  ! -path "./.git/*" \
  ! -path "./node_modules/*" \
  -exec sed -i '' \
    -e "s/{{COMPANY_NAME}}/$COMPANY_NAME/g" \
    -e "s/{{COMPANY_NAME_EN}}/$COMPANY_NAME_EN/g" \
    -e "s/{{SERVICE_NAME}}/$SERVICE_NAME/g" \
    -e "s/{{COMPANY_DOMAIN}}/$COMPANY_DOMAIN/g" \
    -e "s/{{HR_LEAD}}/$HR_LEAD/g" \
    -e "s/{{HR_LEAD_SLACK_ID}}/$HR_LEAD_SLACK_ID/g" \
    -e "s/{{CEO_NAME}}/$CEO_NAME/g" \
    -e "s/{{CPO_NAME}}/$CPO_NAME/g" \
    -e "s/{{CBO_NAME}}/$CBO_NAME/g" \
    -e "s/{{GITHUB_ORG}}/$GITHUB_ORG/g" \
    -e "s/{{HR_SYSTEM}}/$HR_SYSTEM/g" \
    -e "s/{{OFFICE_APP}}/$OFFICE_APP/g" \
    -e "s/{{PASSWORD_MANAGER}}/$PASSWORD_MANAGER/g" \
    -e "s|{{LEADERBOARD_URL}}|$LEADERBOARD_URL|g" \
    {} +
```

> **Linux 사용자**: `sed -i ''` 대신 `sed -i`를 사용하세요.

### 치환 확인

```bash
# 아직 치환되지 않은 플레이스홀더가 있는지 확인
grep -r "{{.*}}" --include="*.md" --include="*.json" . | grep -v ".git/"
```

---

## 5. 선택적 커스터마이징

### 리더보드 (Step 0 Phase 4)

사내 Claude Code 토큰 사용량 리더보드를 운영하지 않는 경우:

1. `.claude/skills/step0-setup/references/phase4-github-leaderboard.md` 파일을 삭제하거나 비활성화
2. `.claude/skills/step0-setup/SKILL.md`에서 Phase 4 관련 내용 제거
3. `{{LEADERBOARD_URL}}` 플레이스홀더는 무시

### 직무별 시나리오 추가/제거 (Step 3)

자사 조직 구조에 따라 시나리오 파일을 추가하거나 제거할 수 있습니다.

- 기본 제공: `phase2-scenarios-sales.md`, `phase2-scenarios-product.md`, `phase2-scenarios-dev.md`, `phase2-scenarios-cx.md`, `phase2-scenarios-mgmt.md`
- 추가가 필요한 경우: 같은 형식으로 `phase2-scenarios-{직무}.md` 파일을 만들고, SKILL.md에서 참조 추가
- 불필요한 직무: 해당 파일을 삭제하고 SKILL.md에서 참조 제거

### Step 6 실서비스 참관

실서비스 참관 Step은 온라인 교육 서비스 기준으로 작성되어 있습니다. 자사 서비스 특성에 따라:

- `.claude/skills/step6-live-audit/references/phase1-preparation.md` — 참관 준비 사항 수정
- `.claude/skills/step6-live-audit/references/phase2-report.md` — 리포트 양식 수정

### 온보딩 커맨드

`.claude/commands/onboarding.md` 파일이 `/onboarding` 슬래시 커맨드의 진입점입니다. 필요에 따라 Step 순서를 조정하거나 Step을 추가/제거할 수 있습니다.

### 에이전트 설정

`.claude/agents/onboarding-agent.md` 파일에서 온보딩 에이전트의 행동 규칙을 조정할 수 있습니다.

---

## 체크리스트: 커스터마이징 완료 확인

- [ ] 플레이스홀더 14개 모두 치환 완료
- [ ] `config/notion-ids.json`에 자사 Notion 페이지 ID 입력
- [ ] `config/team-leads.json`에 자사 조직 구조 입력
- [ ] `references/culture-deck.md`에 자사 컬쳐덱 내용 작성
- [ ] `references/phase1-bm.md`에 자사 BM 정보 작성
- [ ] 직무별 시나리오 파일 작성 (최소 2~3개)
- [ ] Notion 사전 학습 페이지 게시
- [ ] `grep -r "{{.*}}" .` 실행하여 미치환 플레이스홀더 없음 확인
- [ ] `/onboarding` 커맨드 테스트 실행
