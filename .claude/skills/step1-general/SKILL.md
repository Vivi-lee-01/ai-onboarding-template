---
name: step1-general
description: "Step 1 General Onboarding - 회사 문화, 업무 도구 세팅, Slack 인사. 트리거: 'Step 1', 'General', '일반 온보딩', '컬쳐'"
---

# Step 1: General Onboarding

> 팀스페이스의 문화를 이해하고, 업무 도구를 세팅하고, Slack 인사를 보내는 단계.

## 산출물

없음 — Step 1은 세팅 완료가 목표이며, 진행 상태는 `progress.json`에 기록된다.

## STOP PROTOCOL — 절대 위반 금지
> 🔑 **점진적 공개(HARD RULE)**: EXECUTE 과제가 2개 이상이면 한 번에 쏟지 말고 핵심 1개씩 제시→STOP→"다음"으로 진행한다. EXPLAIN은 요약 먼저, 상세는 요청 시 펼친다. (프로젝트 CLAUDE.md "EXECUTE 과제 제시 — 점진적 공개" 참조)

> 이 프로토콜은 이 스킬의 최우선 규칙이다.

### 각 Phase는 반드시 2턴에 걸쳐 진행한다

> 단, EXECUTE에 신규입사자가 직접 할 실행 과제가 없는 읽기 전용 Phase는 CLAUDE.md 예외에 따라 EXPLAIN+CHECK를 1턴으로 진행한다.

Phase A (첫 번째 턴):
1. references/에서 해당 Phase 파일의 EXPLAIN 섹션을 읽는다
2. 내용을 설명한다
3. references/에서 해당 Phase 파일의 EXECUTE 섹션을 읽는다
4. "지금 직접 실행해보세요"라고 안내한다
5. 여기서 반드시 STOP. 턴을 종료한다.

❌ 절대 하지 않는 것: CHECK 섹션 읽기
❌ 절대 하지 않는 것: AskUserQuestion 호출
❌ 절대 하지 않는 것: "실행해봤나요?" 질문

(신규입사자가 "했어", "완료", "다음" 등을 입력)

Phase B (두 번째 턴):
1. references/에서 해당 Phase 파일의 CHECK 섹션을 읽는다
2. AskUserQuestion으로 완료 확인을 한다
3. 피드백 + 격려
4. 기본적으로 다음 Phase로 바로 진행한다. 다만 "더 알아보고 싶거나 멈추고 싶으면 말씀해주세요"라고 한 줄 안내한다.
   (매 Phase마다 AskUserQuestion으로 진행 여부를 묻지 않는다 — 신규입사자가 멈추자고 할 때만 멈춘다)

## 콘텐츠 참조 (로컬 우선)

이 스킬의 공용 콘텐츠는 `content/`의 로컬 사본을 읽는다 (런타임 Notion fetch 없음):
1. 콘텐츠가 필요하면 `content/step1-general.md`를 Read한다 (즉시)
2. 내용을 references의 STOP PROTOCOL 구조에 맞춰 신규입사자에게 전달한다
3. `content/`가 비어 있거나 없으면(아직 미동기화) references 본문의 인라인 내용으로 진행한다

> 콘텐츠 최신화는 운영자가 `/sync-content`로 갱신한다. 신규입사자 세션은 fetch하지 않는다.

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 1 | `references/phase1-culture.md` | 컬쳐덱 + 일하는 방식 |
| Phase 2 | `references/phase2-tools.md` | Slack/Google/Flex/헤이그라운드 세팅 |
| Phase 3 | `references/phase3-checklist.md` | Slack 인사 보내기 |

## 진행 흐름

스킬이 시작되면:
1. Step 1의 목표와 전체 Phase 구성을 간단히 안내한다
2. AskUserQuestion으로 시작할 Phase를 묻는다 (기본: Phase 1부터 순서대로)
3. 선택된 Phase의 references 파일을 읽고 STOP PROTOCOL에 따라 진행한다
4. Phase 3 완료 후 Step 1 마무리 → **자동화 제안** → Step 2 안내

## Step 1 마무리: 자동화 제안

Phase 3 완료 후, Step 2로 넘어가기 전에 MCP 활용 자동화를 제안한다:

> "Step 0에서 연결한 MCP를 활용하면, 이런 자동화도 가능해요!
> 예를 들어 **매일 아침 오늘의 일정 + Slack 주요 채널 업데이트를 자동으로 브리핑** 받을 수 있어요.
> 관심 있으면 온보딩이 끝난 후에 함께 만들어볼까요?"

이 제안의 목적:
- MCP 연결이 단순한 설치가 아니라 **실제 업무에 어떻게 활용되는지** 감을 잡게 함
- 온보딩 이후에도 Claude Code를 계속 사용할 동기 부여
- 강제가 아닌 자연스러운 제안 (관심 없으면 스킵 가능)

## Step 1 완료 처리

Step 1 완료 시 다음만 수행한다:

1. `progress.json`의 `current_step`을 2로 업데이트
2. 아래 마무리 메시지 전달

❌ **하지 않는 것**:
- 산출물 파일 생성 (Step 1은 산출물 없음)
- Slack/HR에 "산출물" 보고 (보고할 산출물이 없음)

## 세션 관리 안내

Step 1 완료 후 다음 메시지를 전달한다:

> "Step 1이 완료되었어요! 🎉 회사 문화와 도구 세팅을 모두 마쳤네요.
> **팁**: 다음 Step은 새 세션에서 시작하면 더 좋은 품질의 응답을 받을 수 있어요.
> `/clear`를 입력하거나 새 터미널을 열고 `/onboarding 이어하기`로 시작하세요.
> 물론 지금 바로 이어서 진행해도 괜찮아요!"
