# 팀스페이스 신규입사자 온보딩

## 프로젝트 개요

신규입사자가 Claude Code를 설치하고 `/onboarding` 커맨드를 실행하면,
AI가 가이드하는 인터랙티브 온보딩이 시작된다.

- **대상**: 팀스페이스(콜라보) 신규입사자 전원
- **진행자**: HR Lead (Dana)
- **구조**: Step 0(설치) → Step 1(General) → Step 2(Product) → Step 3(Biz) → Step 4(스킬 만들기) → Step 5(회고+킥오프) → Step 6(Enterprise 온보딩 세션 참관)

## 구조

```
.claude/skills/
  step0-setup/          # Claude Code 설치 + MCP 연결
  step1-general/        # General Onboarding (컬쳐, 도구, 체크리스트)
  step2-product/        # Product Onboarding (워크스페이스 오너/멤버 체험)
  step3-biz/            # Biz Onboarding (BM, 고객여정)
  step4-skill/          # Build Your First Skill (스킬 해부→설계→구현→PR)
  step5-wrapup/         # Wrap Up (회고 + 킥오프 조언 + Step 6 안내)
  step6-live-audit/     # Enterprise 온보딩 세션 참관 + 모니터링 리포트
```

각 Step 스킬은 `SKILL.md` + `references/*.md` + `evals/evals.json`으로 구성.

## Notion 칸반 자동 업데이트

각 Step 스킬이 **시작될 때** (첫 Phase EXPLAIN 전에) 해당 Step의 칸반 카드를 "시작 전" → **"진행 중"**으로 업데이트한다.
각 Step의 **마지막 Phase CHECK 완료 후** 칸반 카드를 "진행 중" → **"완료"**로 업데이트한다.
상세 로직은 `agents/onboarding-agent.md`의 "Step 시작/완료 시 카드 업데이트" 참조.

> 실패 시 조용히 스킵 — Notion 연동 실패로 온보딩이 중단되면 안 된다.

## STOP PROTOCOL

이 온보딩의 모든 스킬은 STOP PROTOCOL을 따른다.

### 각 Phase는 반드시 2턴에 걸쳐 진행

```
Phase A (첫 번째 턴):
1. references/에서 해당 Phase 파일의 EXPLAIN 섹션을 읽는다
2. 내용을 설명한다
3. references/에서 해당 Phase 파일의 EXECUTE 섹션을 읽는다
4. "지금 직접 실행해보세요"라고 안내한다
5. 여기서 반드시 STOP. 턴을 종료한다.

(신규입사자가 "했어", "완료", "다음" 등을 입력)

Phase B (두 번째 턴):
1. references/에서 해당 Phase 파일의 CHECK 섹션을 읽는다
2. AskUserQuestion으로 완료 확인을 한다
3. 피드백 + 격려
4. AskUserQuestion으로 묻는다:
   "다음 Phase로 넘어갈까요?
    1. 넘어갈게요
    2. 조금 더 알아보고 싶어요"
   → "2"를 선택하면 질문/재실습을 자유롭게 진행한 뒤 다시 4번을 묻는다
```

### 핵심 금지 사항
1. Phase A에서 AskUserQuestion을 호출하지 않는다
2. Phase A에서 CHECK를 먼저 진행하지 않는다
3. 한 턴에 EXPLAIN + CHECK를 동시에 하지 않는다

## 피드백 수집 (각 Step 종료 시)

각 Step의 마지막 Phase CHECK가 끝나고, 마무리 멘트 **전에** 피드백을 수집한다:

1. AskUserQuestion으로 묻는다:
   "이 Step을 진행하면서 불편했던 점, 개선 아이디어, 또는 좋았던 점이 있으면 자유롭게 말씀해주세요!
   (없으면 '없어' 또는 '다음'이라고 입력하세요)"
2. 피드백이 있으면:
   a. `outputs/{닉네임}-{입사일}/onboarding-feedback.md` 파일에 피드백을 추가한다
   b. 기존 파일이 있으면 해당 Step 섹션을 추가, 없으면 아래 구조로 새로 생성한다
   c. Git 브랜치(`org/feedback/{닉네임}-onboarding-voc`)를 생성하거나 기존 브랜치에 커밋한다
   d. PR이 없으면 새로 생성, 있으면 기존 PR에 커밋을 추가한다
   e. "피드백이 PR로 저장되었어요! 감사합니다 🙏" 안내
3. 피드백이 없으면: 그냥 마무리 멘트로 진행한다

### 피드백 파일 구조

```markdown
# 온보딩 피드백 — {닉네임} ({팀}, {조직})

> 온보딩 기간: {입사일} ~ {현재 날짜}

## Step {N}: {Step 이름}
| # | 피드백 | 영향도 |
|---|--------|--------|
| 1 | {내용} | 높음/중간/낮음 |
```

### 영향도 기준
- **높음**: 온보딩 진행이 막히거나, 프로그램 구조 변경이 필요한 경우
- **중간**: UX 개선, 정보 보완, 혼동 방지 등
- **낮음**: 문구 수정, 사소한 개선 제안

## 설계 원칙

- **결과물 중심**: 각 Step = 완성되는 산출물 1개
- **템플릿 먼저**: 미션 시작 시 템플릿 제공 → 점진적 채우기
- **Notion 동적 참조**: references에 Notion 콘텐츠를 직접 복사하지 않음. MCP로 실시간 fetch
- **점진적 난이도**: 따라하기(Step 0~1) → 응용하기(Step 2~3) → 만들기(Step 4~5)

## MCP 연결 전제 조건

모든 Step에서 MCP(Notion, Slack, Gmail, Calendar)를 사용하기 전에:

1. **Step 0에서 연결이 완료된 것을 전제**로 한다
2. 만약 MCP 호출이 실패하면 (에러, 타임아웃 등):
   - 신규입사자에게 "커넥터 연결이 아직 안 된 것 같아요"라고 안내
   - Claude.ai > Settings > Integrations에서 해당 서비스 연결 방법을 다시 안내
   - 회사 계정(`@teamspace.io`)으로 OAuth 인증했는지 확인
   - `/mcp` 명령어로 연결 상태 확인 안내
   - 연결 후 Claude Code 재시작 필요할 수 있음 안내
3. MCP 실패로 온보딩 전체가 멈추면 안 된다 — 해당 실습을 스킵하고 다음으로 넘어갈 수 있도록 안내

## Notion 동적 참조

references 파일에서 Notion 콘텐츠가 필요하면 `config/notion-ids.json`의 ID를 사용하여
MCP(notion-fetch)로 최신 콘텐츠를 가져온다. 하드코딩하지 않는다.

## 산출물 저장

산출물은 **Notion 페이지**가 원본. `outputs/{닉네임}-{입사일}/`은 Notion MCP 실패 시 fallback 전용.

| Step | 산출물 | 저장 위치 |
|------|--------|-----------|
| Step 1 | (없음 — 세팅 완료가 목표) | progress.json 기록만 |
| Step 2 | 개밥먹기 노션 문서 + AI 개선안 (선택) | **Notion** (실패 시 로컬 fallback) |
| Step 3 | (없음 — 시나리오 퀘스트 + CHECK가 학습 확인) | progress.json 기록만 |
| Step 4 | 나만의 스킬 폴더 | **GitHub** (teamspace-ai-all org) |
| Step 5 | (없음 — 회고 + 킥오프 조언) | progress.json 기록만 |
| Step 6 | (없음 — 청강 자체가 목표) | progress.json 기록만 |

## 산출물 보존

- **Step 0~3**: Notion 페이지가 원본. 로컬 MD는 Notion MCP 실패 시 fallback 전용. Step 5~6은 산출물 없음 (progress.json 기록만).
- **Step 4**: GitHub(`teamspace-ai-all` org)에 push. 여기서 처음 GitHub 계정 세팅.
- 온보딩은 여러 날에 걸쳐 진행되므로, `progress.json`으로 진행 상태를 추적한다.
- 다음 날 `/onboarding 이어하기`로 복귀 시 progress.json을 읽어 중단 지점부터 재개.

## 프로젝트 문서 (Lazy Loading)

상세 내용은 별도 파일에 있으며, Claude가 필요할 때만 읽는다:
- Notion 페이지 ID: @config/notion-ids.json
- WAT 설계 템플릿: @docs/wat-template.md
- 운영 대시보드: @TODO.md

## 언어

- 모든 응답은 한국어로 작성한다
- 신규입사자에게 친근하고 환영하는 톤을 유지한다
- 존댓말을 사용한다
