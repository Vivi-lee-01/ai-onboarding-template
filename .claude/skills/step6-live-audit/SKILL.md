---
name: step6-live-audit
description: "Step 6 실서비스 참관 -- 참관 대상 확인, 참관 준비, Notion 가이드 안내. 트리거: 'Step 6', '실서비스 참관', '모니터링'"
---

# Step 6: 실서비스 참관

> 실서비스/핵심 고객 사례를 참관하여 온보딩에서 배운 내용을 실전에서 확인한다.

## 산출물

**실서비스 모니터링 리포트** -- 참관 후 관찰 내용을 구조화한 리포트.
`outputs/{닉네임}-{입사일}/step6-live-audit-report.md` + Notion 페이지에 저장.

## 왜 마지막인가?

실서비스 참관은 온보딩의 모든 학습(서비스 체험, BM 이해, 고객 여정)을 **실전에서 확인**하는 과정입니다.
Step 1~5를 마친 상태에서 관찰해야 깊이 있는 인사이트를 얻을 수 있습니다.

또한 참관 일정이 외부에 의존하므로, 온보딩 흐름을 멈추지 않고
Step 5까지 완료한 후 참관 일정에 맞춰 비동기로 진행합니다.

## STOP PROTOCOL -- 절대 위반 금지

> 이 프로토콜은 이 스킬의 최우선 규칙이다.

### 각 Phase는 반드시 2턴에 걸쳐 진행한다

Phase A (첫 번째 턴):
1. references/에서 해당 Phase 파일의 EXPLAIN 섹션을 읽는다
2. 내용을 설명한다
3. references/에서 해당 Phase 파일의 EXECUTE 섹션을 읽는다
4. "지금 직접 실행해보세요"라고 안내한다
5. 여기서 반드시 STOP. 턴을 종료한다.

Phase B (두 번째 턴):
1. references/에서 해당 Phase 파일의 CHECK 섹션을 읽는다
2. AskUserQuestion으로 확인 질문을 한다
3. 피드백을 준다
4. 온보딩 최종 마무리 안내

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 1 | `references/phase1-preparation.md` | 참관 준비 -- 참관 대상 확인 + 일정 선택 + 근무 조정 안내 + Notion 가이드 |
| Phase 2 | `references/phase2-report.md` | 모니터링 리포트 -- 참관 관찰 정리 + 리포트 작성 + 온보딩 완주 마무리 |

## Notion 동적 참조

`config/notion-ids.json`의 `step6_live_audit` ID로 실서비스 참관 가이드 Notion 페이지를 fetch하여
최신 정보를 반영한다.

## 비동기 진행

이 Step은 다른 Step과 달리 **비동기**로 진행됩니다:

1. Phase 1 (준비): 참관 대상 확인 + 일정 선택 + Notion 가이드 확인
2. (참관 당일): 실제 참관 진행 (모니터링 채널에 참여)
3. Phase 2 (리포트): 참관 관찰 내용을 모니터링 리포트로 정리
4. 리포트 완료 -> **온보딩 최종 마무리**

## 진행 흐름

스킬이 시작되면:
1. Step 6의 목표를 안내한다 (실서비스 참관 + 모니터링 리포트)
2. Phase 1의 references 파일을 읽고 STOP PROTOCOL에 따라 진행한다
3. Phase 1 CHECK에서 참관 날짜 확인 + 리마인더 설정
4. "참관 끝나면 `/onboarding 이어하기`로 돌아와서 Phase 2를 진행하세요!" 안내
5. (비동기 -- 참관 후 복귀)
6. Phase 2의 references 파일을 읽고 STOP PROTOCOL에 따라 진행한다
7. Phase 2 CHECK에서 리포트 확인 + 전체 온보딩 완주 축하
8. HR({{HR_LEAD}})에게 온보딩 완료 Slack 알림 발송

## 세션 관리 안내

Phase 1 완료 후 (참관 전) 다음 메시지를 전달한다:

> "Phase 1이 완료되었어요! 실서비스 참관은 일정에 맞춰 진행하시면 됩니다.
> 참관이 끝나면 새 세션에서 `/onboarding 이어하기`로 돌아와서 Phase 2(모니터링 리포트)를 진행하세요."

Phase 2 완료 후 (전체 온보딩 완주) 다음 메시지를 전달한다:

> "온보딩 캠프를 모두 완주하셨어요!
> 지금까지 열심히 따라와주셔서 정말 감사합니다.
> 앞으로의 여정도 응원합니다. 궁금한 게 있으면 언제든 Claude에게 물어보세요!"
