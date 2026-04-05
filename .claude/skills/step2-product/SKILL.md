---
name: step2-product
description: "Step 2 Product Onboarding - 서비스 제공자/이용자 관점 제품 체험, 개밥먹기 노션 문서 작성. 트리거: 'Step 2', 'Product', '제품 체험', '개밥먹기'"
---

# Step 2: Product Onboarding

> 서비스 제공자와 이용자, 두 관점으로 {{SERVICE_NAME}}를 직접 체험하고,
> 개밥먹기 노션 문서 + AI 개선안을 Notion에 생성한다.

## 산출물

1. **Notion**: 신규입사자 온보딩 카드 하위에 문서 생성
   - "개밥먹기 — {닉네임}" (원본 관찰 기록)
   - (선택) "AI 제품 개선안 — {닉네임}" (Claude가 분석한 개선 제안)
2. **Notion 실패 시 fallback**: `outputs/{닉네임}-{입사일}/step2-product-report.md` (Notion MCP 실패 시에만 로컬 저장)

## STOP PROTOCOL — 절대 위반 금지

> 이 프로토콜은 이 스킬의 최우선 규칙이다.

### 각 Phase는 반드시 2턴에 걸쳐 진행한다

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
4. 다음 Phase로 이동할지 AskUserQuestion으로 묻는다

## Notion 동적 참조

Step 2 Product Onboarding Notion 페이지(`step2_product` ID)를 fetch하여
최신 체험 가이드와 체크리스트를 반영한다.

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 0 | `references/phase0-product-team.md` | 제품팀 + 개발팀 조직 소개 |
| Phase 1 | `references/phase1-experience.md` | 서비스 제공자 + 이용자 체험 (통합) |
| Phase 2 | `references/phase2-report.md` | AI 제품 개선안 생성 (선택) |

## 진행 흐름

스킬이 시작되면:
1. Step 2의 목표와 "개밥먹기" 개념을 간단히 안내한다
2. **Phase 0에서 제품팀 조직 구조를 먼저 소개**한다 (제품 체험 전 맥락 제공)
3. Phase 1에서 서비스 제공자 + 이용자 체험을 **한 번에 안내** + **개밥먹기 노션 문서에 기록**
4. Phase 2에서 AI 개선안 생성 여부를 **선택** (필수가 아님)
5. Step 2 마무리 멘트 + Step 3 안내

## Step 2 완료 처리

Step 2 완료 시 다음을 순서대로 수행한다:

### 1. 도메인 오너({{CPO_NAME}})에게 커피챗 요청 Slack DM 발송

`config/team-leads.json`의 `step_domain_owners.step2`에서 {{CPO_NAME}}의 Slack ID를 가져와 DM을 보낸다.

메시지 예시:
> "안녕하세요 {{CPO_NAME}}님! {닉네임}({직무})입니다. Product Onboarding을 마쳤는데, 제품에 대해 더 여쭤보고 싶은 게 있어요. 편하신 시간에 커피챗 한 번 가능할까요? ☕"

⚠️ 단, 신규입사자의 소속 팀이 제품팀({{CPO_NAME}} 직속)인 경우 → 이미 팀 내에서 만날 수 있으므로 스킵

### 2. 대상자에게 안내 + 세션 관리 메시지

> "{{CPO_NAME}}(CPO)님께 커피챗 요청 메시지를 보냈어요! ☕ 제품에 대해 궁금한 점을 직접 여쭤볼 수 있는 좋은 기회가 될 거예요.
>
> Step 2가 완료되었어요! 🎉 서비스 제공자와 이용자 관점을 모두 체험했네요.
> **팁**: Step 3은 BM과 고객 여정을 깊이 파고드는 단계예요. 새 세션에서 시작하면 더 집중된 응답을 받을 수 있어요.
> `/clear` 또는 새 터미널에서 `/onboarding 이어하기`로 시작하세요.
> 물론 지금 바로 이어서 진행해도 괜찮아요!"
