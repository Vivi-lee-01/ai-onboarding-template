---
name: step5-wrapup
description: "Step 5 회고 + 팀 킥오프 조언 — 캠프 전체 회고, 팀 합류 전 가벼운 조언. 트리거: 'Step 5', '회고', '마무리', 'wrap up', '킥오프'"
---

# Step 5: Wrap Up — 회고 + 팀 킥오프 조언

> 온보딩 캠프 전체를 회고하고, 팀 합류 전 가벼운 조언을 전달한다.

## 산출물

- (없음 — 회고 대화 + 킥오프 조언이 목적)
- progress.json 기록만

## STOP PROTOCOL — 절대 위반 금지

> 이 프로토콜은 이 스킬의 최우선 규칙이다.

### 각 Phase는 반드시 2턴에 걸쳐 진행한다

Phase A (첫 번째 턴):
1. references/에서 해당 Phase 파일의 EXPLAIN 섹션을 읽는다
2. 내용을 설명한다
3. references/에서 해당 Phase 파일의 EXECUTE 섹션을 읽는다
4. "지금 직접 실행해보세요"라고 안내한다
5. 여기서 반드시 STOP. 턴을 종료한다.

❌ 절대 하지 않는 것: CHECK 질문, CHECK 섹션 읽기
❌ 절대 하지 않는 것: AskUserQuestion 호출
❌ 절대 하지 않는 것: "실행해봤나요?" 질문

(참가자가 "했어", "완료", "다음" 등을 입력)

Phase B (두 번째 턴):
1. references/에서 해당 Phase 파일의 CHECK 섹션을 읽는다
2. AskUserQuestion으로 확인 질문을 한다
3. 피드백을 준다
4. AskUserQuestion으로 묻는다:
   "다음 Phase로 넘어갈까요?
    1. 넘어갈게요
    2. 조금 더 알아보고 싶어요"
   → "2"를 선택하면 질문/재실습을 자유롭게 진행한 뒤 다시 4번을 묻는다

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 1 | `references/phase1-retrospective.md` | 회고 + VoC 통합 — 오픈 대화 |
| Phase 2 | `references/phase2-action-plan.md` | 팀 킥오프 전 가벼운 조언 |

> `phase3-feedback.md`는 Phase 1에 통합되어 더 이상 별도 Phase로 사용하지 않는다.

## 진행 흐름

스킬이 시작되면:
1. Step 5의 목표를 간단히 안내한다
2. Phase 1에서 오픈 대화로 회고 + VoC를 함께 수집한다
3. Phase 2에서 팀 킥오프 전 가벼운 조언을 전달한다
4. 온보딩 캠프 마무리 멘트를 전달한다

## 세션 관리 안내

Step 5 완료 후 다음 메시지를 전달한다:

> "Step 5가 완료되었어요! 온보딩 캠프의 핵심 과정을 모두 마쳤네요.
>
> 온보딩에서 배운 핵심 내용을 하나의 파일로 정리해드릴까요?
> 이 파일을 Claude Code에서 참조하면, 앞으로 업무 중에도 회사 맥락을 자동으로 파악해줘요.
> (정리하려면 '응' 또는 '좋아'라고 답해주세요)"

동의하면 **`onboarding-extract`** 스킬을 호출하여 핵심 콘텐츠 추출을 진행한다.
거절하면 Step 6 안내로 넘어간다.

## Step 6 간단 안내 (Step 5 직후 실행)

Step 5가 끝나면 **별도 세션 없이 바로** Step 6을 간단히 안내한다.
Step 6 스킬을 호출하지 않고, 아래 내용을 직접 전달한다:

1. progress.json에서 `notion_kanban_ds`를 읽고, 칸반 DB에서 "청강" 키워드로 카드를 검색한다
2. 찾으면 해당 카드(Enterprise 온보딩 세션 참관) URL을 안내한다: "Enterprise 온보딩 세션 참관 가이드는 여기 있어요!"
3. 못 찾으면 fallback: `notion-fetch`로 일반 가이드 페이지(`step6_live_audit` ID)를 안내한다
3. 다음 3가지를 당부한다:
   - 노션 가이드를 꼭 확인할 것
   - **백오피스**(admin.collabo.io)에서 청강 대상 라이브를 확정할 것
   - **팀 내에 청강 일정 + 근무 스케줄을 꼭 공유**할 것
4. 마무리 멘트 — **이 안내를 마지막으로 클로드를 통한 온보딩은 종료**:
   > "이것으로 클로드를 통한 온보딩이 모두 끝났어요!
   > Enterprise 온보딩 세션 참관은 노션 가이드를 참고해서 직접 진행해주세요.
   > 지금까지 열심히 따라와주셔서 정말 감사합니다. 앞으로의 여정도 응원합니다!"
5. progress.json에 `onboarding_completed: true` 기록
6. **자동 Slack 알림 발송** — `config/team-leads.json`에서 대상자의 소속팀 정보를 조회하여:
   - **일반 구성원인 경우**: 팀장 + 셀 리드(있는 경우)에게 DM
   - **팀장(C레벨)이 온보딩 대상자인 경우**: 대표(James)에게 DM
   - DM 내용:
     > ":tada: *온보딩 완료 알림*\n{닉네임} ({직무}, {팀})의 기본 온보딩이 완료되었습니다.\nEnterprise 온보딩 세션 참관 모니터링 참여를 독려해주세요!"
   - **HR(Dana)**에게도 항상 온보딩 완료 DM 발송:
     > ":white_check_mark: *온보딩 완료*\n{닉네임} ({직무}, {팀})의 클로드 온보딩이 모두 완료되었습니다. Enterprise 온보딩 세션 참관은 리더에게 독려 메시지를 보냈어요."
