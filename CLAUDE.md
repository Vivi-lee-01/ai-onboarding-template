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

### 예외 — 읽기 전용 Phase는 1턴

EXECUTE에 신규입사자가 직접 할 실행 과제가 **없는** Phase(예: 로드맵 안내, 순수 정보 전달)는
EXPLAIN과 CHECK를 한 턴에 처리한다. "확인했어" 입력만 받는 빈 턴을 만들지 않는다.
판단 기준: 해당 reference의 EXECUTE 섹션에 사용자 행동 지시가 있으면 2턴, 없으면 1턴.

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
4. 기본적으로 다음 Phase로 바로 진행한다. 다만 "더 알아보고 싶거나 멈추고 싶으면 말씀해주세요"라고 한 줄 안내한다.
   (매 Phase마다 AskUserQuestion으로 진행 여부를 묻지 않는다 — 신규입사자가 멈추자고 할 때만 멈춘다)
```

### 핵심 금지 사항
1. Phase A에서 AskUserQuestion을 호출하지 않는다
2. Phase A에서 CHECK를 먼저 진행하지 않는다
3. 한 턴에 EXPLAIN + CHECK를 동시에 하지 않는다

## EXECUTE 과제 제시 — 점진적 공개 (인지 부하 최소화)

> VoC(2026-06-02): "한 번에 너무 많은 내용을 줘서 뭘 해야 할지 모르겠다."
> EXPLAIN 벽 + EXECUTE 과제 다발을 한 메시지에 쏟으면 신규입사자가 압도된다.

규칙:
1. **EXECUTE에 실행 과제가 2개 이상이면 한 번에 다 제시하지 않는다.** 핵심 과제 1개만 안내하고 STOP → 신규입사자가 "했어/다음"이라고 하면 다음 과제 1개를 제시한다.
   - 예외: 각 과제가 한 줄짜리 짧은 명령이고 서로 의존적이면(예: Step 0 Phase 1의 커넥터 4개 연결 + 확인 실습) 묶어서 제시해도 된다. 판단 기준 = "신규입사자가 한 화면에서 부담 없이 다 할 수 있는가".
2. **EXPLAIN은 핵심 요약을 먼저** 제시한다. 표·비유·트러블슈팅 같은 상세는 "더 알고 싶으면 물어보세요" 한 줄로 접어두고, 신규입사자가 요청할 때만 펼친다.
3. 한 메시지의 목표 = "지금 당장 할 행동 1개가 명확할 것". 행동이 2개 이상 보이면 분할 신호다.

## 시나리오·퀴즈 출제 규칙 (HARD RULE)

> Step 3 Phase 2의 시나리오 퀴즈처럼 **"상황 설명 + Q1/Q2 + 선택지 a/b/c/d"** 가 있는 콘텐츠는
> **반드시 일반 어시스턴트 메시지(plain text)로 본문·질문·선택지를 모두 출력한 뒤 STOP** 한다.
>
> ❌ **AskUserQuestion으로 시나리오/퀴즈를 묻지 않는다.**
> 이유: AskUserQuestion의 TUI 위젯은 짧은 질문 헤더 + 2~4개 선택지 버튼만 렌더링하기 때문에,
> 시나리오 본문(narrative)과 Q1/Q2 텍스트가 화면에 노출되지 않는다.
> 실제로 신규입사자(Windy, 2026-05)가 "선택지만 보이고 문제가 안 보인다"는 VoC를 남긴 케이스가 있다.
>
> ✅ **올바른 방식**:
> 1. references의 시나리오 블록(상황 설명 + Q1 + 선택지 + Q2 + 선택지)을 **그대로 메시지에 출력** 한다
> 2. 마지막에 "원하는 답을 자유롭게 입력해주세요 (예: `b, c` / `2번, 3번` / 키워드 뭐든 OK)"라고 안내
> 3. 턴 종료. 신규입사자의 자유 텍스트 답변을 기다린다
> 4. AskUserQuestion은 **"다음 Phase로 넘어갈까요?"** 같이 선택지 길이가 짧고 본문 없이도 의미가 통하는 yes/no·next/back 흐름에만 사용

## references 파일 읽기 규칙 (응답 대기 시간 최소화)

> 응답 대기 시간이 길다는 VoC(2026-05 Windy) 대응 — 입력 토큰을 최소화한다.

각 Phase의 references 파일은 두 개로 분리되어 있다:
- `{phase}.md` — EXPLAIN + EXECUTE 섹션만 포함 (Phase A 턴용)
- `{phase}-check.md` — CHECK 섹션만 포함 (Phase B 턴용)

규칙:
1. **Phase A 턴에서는 `{phase}.md`만 읽는다.** `-check.md`는 절대 미리 읽지 않는다.
2. **Phase B 턴에서는 `{phase}-check.md`만 읽는다.** 본 파일을 다시 읽지 않는다 (이전 턴 컨텍스트로 충분).
3. `-check.md`가 없는 phase 파일은 분리되지 않은 케이스 — 그대로 본 파일을 읽는다.
4. **여러 references 파일을 한 번에 읽지 않는다.** 현재 진행 중인 Phase의 해당 파일 1개만 읽는다.

## Notion fetch 캐싱 정책 (응답 대기 시간 최소화)

> notion-fetch 1회당 1~3초 소요. Phase마다 호출하면 누적 대기 시간이 커진다.

규칙:
1. 한 Step의 **첫 Phase 시작 시 1회만** `notion-fetch`를 호출한다.
2. 결과는 컨텍스트에 유지된 채로 같은 Step의 이후 Phase에서 재사용한다 (다시 fetch 하지 않는다).
3. 새 세션으로 Step을 이어할 때만 Step 첫 Phase에서 fetch 1회 수행.
4. Step이 바뀌면 새 Step의 첫 Phase에서 다시 1회 fetch.
5. fetch 실패 시 신규입사자에게 알리되, references의 기본 콘텐츠로 진행한다 (블로킹하지 않음).

## 인사이트 블록 출력 빈도 (응답 대기 시간 최소화)

> 출력 토큰 = 사용자 대기 시간. 인사이트는 진짜 가치 있을 때만 넣는다.

규칙:
1. **Step당 최대 2회**. 한 Step에서 이미 2회 출력했으면, 남은 턴은 본문만 출력하고 종료한다.
2. **출력 금지 위치**: EXPLAIN 직후, CHECK 직후, Phase 시작 멘트, Phase 완료 멘트, Step 마무리 멘트.
3. 진짜로 "왜 이렇게 되어 있는지"가 신규입사자 입장에서 의문이 될 만한 지점에서만, 다른 Phase·Step과의 연결고리를 만들 수 있을 때만 출력.

## 피드백 수집 (각 Step 종료 시)

각 Step의 마지막 Phase CHECK가 끝나고, 마무리 멘트 **전에** 피드백을 수집한다:

1. AskUserQuestion으로 묻는다:
   "이 Step을 진행하면서 불편했던 점, 개선 아이디어, 또는 좋았던 점이 있으면 자유롭게 말씀해주세요!
   (없으면 '없어' 또는 '다음'이라고 입력하세요)"
2. 피드백이 있으면:
   a. `outputs/{닉네임}-{입사일}/onboarding-feedback.md` 파일에 피드백을 추가한다
   b. 기존 파일이 있으면 해당 Step 섹션을 추가, 없으면 아래 구조로 새로 생성한다

   > ⏱️ **순서 규칙(비차단)**: Step 종료 멘트와 다음 Step 안내를 **먼저** 신규입사자에게 보여준 뒤, 아래 피드백 PR 생성(git 브랜치/커밋/PR)은 그 다음에 조용히 처리한다. PR 생성 지연이 마무리 체감을 늦추지 않게 한다.

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
- **콘텐츠 로컬 우선**: 공용 읽기 콘텐츠는 `content/`의 로컬 사본을 읽는다 (런타임 fetch 없음). Notion은 편집 원본이며, `/sync-content`로 `content/`를 갱신한다.
- **Notion은 쓰기·개인 콘텐츠**: 칸반 상태, 개밥먹기 문서, AI 개선안 등 read-write/개인 페이지만 런타임 Notion MCP 사용.
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

## 콘텐츠 참조 (로컬 우선)

references 파일에서 공용 읽기 콘텐츠가 필요하면 `content/`의 로컬 사본을 Read한다 (런타임 fetch 없음).
콘텐츠가 없거나 비어 있으면(아직 미동기화) references 인라인 내용으로 진행한다.
최신화는 운영자가 `/sync-content`로 Notion → `content/`를 갱신한다. 신규입사자 세션은 fetch하지 않는다.
칸반·개밥먹기·AI 개선안 등 read-write/개인 페이지만 런타임 Notion MCP를 사용한다.

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
