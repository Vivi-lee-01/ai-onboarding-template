---
name: step3-biz
description: "Step 3 Biz Onboarding - 비즈니스 모델 이해, 고객 여정, 직무 연결 인사이트. 트리거: 'Step 3', 'Biz', '비즈니스', 'BM', '고객 여정'"
---

# Step 3: Biz Onboarding

> 콜라보의 비즈니스 모델을 이해하고, 경쟁 포지셔닝과 시장 데이터를 파악하고, 고객 여정을 학습하고, 내 직무와의 연결점을 찾는다.

## 산출물

- (없음 — 시나리오 퀘스트 + Phase 3 CHECK 응답이 학습 확인을 대체)
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

❌ 절대 하지 않는 것: CHECK 섹션 읽기
❌ 절대 하지 않는 것: AskUserQuestion 호출
❌ 절대 하지 않는 것: "실행해봤나요?" 질문

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

## Notion 동적 참조

Step 3 Biz Onboarding Notion 페이지(`step3_biz` ID)를 fetch하여
최신 BM 정보와 고객 여정을 반영한다.

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 0 | `references/phase0-biz-team.md` | Growth팀 + Operations팀 조직 소개 |
| Phase 1 | `references/phase1-bm.md` | BM + 경쟁 포지셔닝 + 시장 데이터 + 용어집 + 고객 여정 |
| Phase 2 | `references/phase2-customer.md` | 시나리오 퀘스트 + Slack 팀 연결 |
| Phase 3 | `references/phase3-team-deep-dive.md` | 팀별 심화 (BM 연결 + 업무 도구) |

## 팀별 분기

Phase 2(시나리오 퀘스트)에서 팀별 분기가 발생한다.
신규입사자의 **소속 팀 업무에서 타 팀과 연계가 필요한 시나리오** 2개를 선택하여 제공한다.
"타 팀의 문제를 풀어라"가 아니라, **"내 일을 하면서 이 팀과 이렇게 연결된다"**를 체험한다.
시나리오 답변 후 연계 팀 담당자에게 **실제 Slack 인사 메시지**를 보내는 퀘스트가 포함된다.

Phase 3(팀별 심화)에서는 신규입사자의 **소속 팀**에 맞는 BM 연결 포인트와 업무 도구를 안내한다.

## 진행 흐름

스킬이 시작되면:
1. Step 3의 목표를 간단히 안내한다
2. **Phase 0에서 Growth팀 조직 구조를 먼저 소개**한다 (BM 학습 전 맥락 제공)
3. Phase 1에서 BM 구조, 경쟁 포지셔닝, 시장 데이터, 핵심 용어, 고객 여정을 학습한다
4. Phase 2에서 시나리오 퀘스트 + Slack DM 퀘스트를 진행한다 — 팀별 분기
5. Phase 3에서 팀별 심화 (BM 연결 + 업무 도구)를 학습한다
6. Phase 3 완료 후 Step 4로의 전환 안내

## Step 3 완료 처리

Step 3 완료 시 다음을 순서대로 수행한다:

### 1. 도메인 오너(Morgan)에게 커피챗 요청 Slack DM 발송

`config/team-leads.json`의 `step_domain_owners.step3`에서 Morgan의 Slack ID를 가져와 DM을 보낸다.

메시지 예시:
> "안녕하세요 Morgan님! {닉네임}({직무})입니다. Biz Onboarding을 마쳤는데, 비즈니스에 대해 더 여쭤보고 싶은 게 있어요. 편하신 시간에 커피챗 한 번 가능할까요? ☕"

⚠️ 단, 신규입사자의 소속 팀이 Growth팀(Morgan 직속)인 경우 → 이미 팀 내에서 만날 수 있으므로 스킵

### 2. 대상자에게 안내 + 세션 관리 메시지

> "Morgan(CBO)님께 커피챗 요청 메시지를 보냈어요! ☕ 비즈니스에 대해 궁금한 점을 직접 여쭤볼 수 있는 좋은 기회가 될 거예요.
>
> Step 3이 완료되었어요! 🎉 비즈니스 모델과 고객 여정을 파악했네요.
> **팁**: Step 4는 직접 스킬을 만들고 GitHub PR까지 하는 실전 단계예요. 새 세션에서 시작하면 더 좋은 결과를 얻을 수 있어요.
> `/clear` 또는 새 터미널에서 `/onboarding 이어하기`로 시작하세요.
> 물론 지금 바로 이어서 진행해도 괜찮아요!"
