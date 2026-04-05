# {{COMPANY_NAME}} 신규입사자 온보딩

## 프로젝트 개요

신규입사자가 Claude Code를 설치하고 `/onboarding` 커맨드를 실행하면,
AI가 가이드하는 인터랙티브 온보딩이 시작된다.

- **대상**: {{COMPANY_NAME}}({{SERVICE_NAME}}) 신규입사자 전원
- **진행자**: HR Lead ({{HR_LEAD}})
- **구조**: Step 0(설치) → Step 1(General) → Step 2(Product) → Step 3(Biz) → Step 4(스킬 만들기) → Step 5(회고+킥오프) → Step 6(실서비스 참관)

## 구조

```
.claude/skills/
  step0-setup/          # Claude Code 설치 + MCP 연결
  step1-general/        # General Onboarding (컬쳐, 도구, 체크리스트)
  step2-product/        # Product Onboarding (제품/서비스 체험)
  step3-biz/            # Biz Onboarding (BM, 고객여정)
  step4-skill/          # Build Your First Skill (스킬 해부→설계→구현→PR)
  step5-wrapup/         # Wrap Up (회고 + 킥오프 조언)
  step6-live-audit/     # 실서비스 참관 + 모니터링 리포트
```

각 Step 스킬은 `SKILL.md` + `references/*.md` + `evals/evals.json`으로 구성.

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
4. 다음 Phase로 이동할지 묻는다
```

### 핵심 금지 사항
1. Phase A에서 AskUserQuestion을 호출하지 않는다
2. Phase A에서 CHECK를 먼저 진행하지 않는다
3. 한 턴에 EXPLAIN + CHECK를 동시에 하지 않는다

## 설계 원칙

- **결과물 중심**: 각 Step = 완성되는 산출물 1개
- **템플릿 먼저**: 미션 시작 시 템플릿 제공 → 점진적 채우기
- **Notion 동적 참조**: references에 Notion 콘텐츠를 직접 복사하지 않음. MCP로 실시간 fetch
- **점진적 난이도**: 따라하기(Step 0~1) → 응용하기(Step 2~3) → 만들기(Step 4~5)

## MCP 연결 전제 조건

모든 Step에서 MCP(Notion, Slack, Gmail, Calendar)를 사용하기 전에:

1. **Step 0에서 연결이 완료된 것을 전제**로 한다
2. 만약 MCP 호출이 실패하면:
   - 신규입사자에게 "커넥터 연결이 아직 안 된 것 같아요"라고 안내
   - Claude.ai > Settings > Integrations에서 해당 서비스 연결 방법을 다시 안내
   - 회사 계정(`@{{COMPANY_DOMAIN}}`)으로 OAuth 인증했는지 확인
   - `/mcp` 명령어로 연결 상태 확인 안내
3. MCP 실패로 온보딩 전체가 멈추면 안 된다 — 해당 실습을 스킵하고 다음으로 넘어갈 수 있도록 안내

## Notion 동적 참조

references 파일에서 Notion 콘텐츠가 필요하면 `config/notion-ids.json`의 ID를 사용하여
MCP(notion-fetch)로 최신 콘텐츠를 가져온다. 하드코딩하지 않는다.

## 산출물 저장

산출물은 **Notion 페이지**가 원본. `outputs/{닉네임}-{입사일}/`은 Notion MCP 실패 시 fallback 전용.

## 프로젝트 문서 (Lazy Loading)

상세 내용은 별도 파일에 있으며, Claude가 필요할 때만 읽는다:
- Notion 페이지 ID: @config/notion-ids.json
- WAT 설계 템플릿: @docs/wat-template.md

## 언어

- 모든 응답은 한국어로 작성한다
- 신규입사자에게 친근하고 환영하는 톤을 유지한다
- 존댓말을 사용한다
