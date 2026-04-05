---
name: step4-skill
description: "Step 4 나만의 스킬 만들기 — 스킬 구조 이해, 설계, 구현, GitHub PR까지. 트리거: 'Step 4', '스킬 만들기', 'build skill', 'GitHub'"
---

# Step 4: Build Your First Skill

> 스킬의 구조를 해부하고, 나만의 업무 자동화 스킬을 설계·구현하여 GitHub PR로 제출한다.

## 산출물

- **GitHub**: `{{GITHUB_ORG}}` org 리포지토리에 PR 제출 (나만의 스킬 폴더)
- **로컬 백업**: `outputs/{닉네임}-{입사일}/step4-my-first-skill/` (SKILL.md + references/ + evals/)

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
4. 다음 Phase로 이동할지 AskUserQuestion으로 묻는다

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 1 | `references/phase1-skill-anatomy.md` | 스킬 해부 — 구조와 동작 원리 |
| Phase 2 | `references/phase2-design.md` | 스킬 설계 — 문제 정의 + 입출력 + 단계 |
| Phase 3 | `references/phase3-implementation.md` | 구현 + eval + Git PR |

## 왜 Git/PR을 배우는가

> Phase 1 도입부 또는 Phase 3 도입부에서 아래 내용을 전달한다.

{{COMPANY_NAME}}는 **`{{GITHUB_ORG}}`** 이라는 AI 산출물 공용 레포지토리를 운영하고 있다.
모든 직원이 만든 스킬, 프롬프트, 자동화 도구가 이 한 곳에 쌓이면서 **복리 효과**가 생긴다 — 내가 만든 스킬을 다른 팀이 쓰고, 다른 팀이 만든 스킬을 내가 쓰고, 서로의 산출물이 발전의 재료가 된다.

Git과 PR은 개발자만의 도구가 아니다. **AI Native 조직의 지식 관리 인프라**다.
코드를 짜기 위해서가 아니라, AI와 함께 만든 결과물을 안전하게 공유하고 리뷰받기 위한 워크플로우다.

그리고 가장 중요한 것: **Git 명령어를 외울 필요가 없다.**
Claude Code가 브랜치 생성, 커밋, PR 제출까지 전부 대신 해준다. 여러분은 "커밋하고 PR 만들어줘"라고 말하기만 하면 된다.

## 팀별 스킬 아이디어 분기

Phase 2에서 스킬 아이디어를 제안할 때, `progress.json`의 팀 정보를 참조하여 예시를 다르게 제공한다.
팀 정보가 없으면 먼저 "어떤 팀에서 일하게 되나요?"를 AskUserQuestion으로 확인한다:

- **세일즈**: 고객사 브리핑 생성기, 미팅 준비 도우미, 일일 리드 대시보드
- **개발**: PR 리뷰 요약기, 배포 상태 체크, 코드 품질 리포트 생성기
- **제품**: 유저 피드백 수집기, 스프린트 요약 생성기, 경쟁사 업데이트 모니터
- **경영관리(HR/재무)**: 월간 인원 현황 리포트 생성기, 비용 정산 체크리스트 자동화, 온보딩 진행 상태 트래커
- **CX**: 고객 문의 유형별 주간 리포트, FAQ 자동 업데이트 도우미, VOC 트렌드 분석기
- **{추가 팀}**: {팀에 맞는 스킬 아이디어 3개}

## 진행 흐름

스킬이 시작되면:
1. Step 4의 목표와 전체 Phase 구성을 간단히 안내한다
2. AskUserQuestion으로 시작할 Phase를 묻는다 (기본: Phase 1부터 순서대로)
3. 선택된 Phase의 references 파일을 읽고 STOP PROTOCOL에 따라 진행한다
4. Phase 3 완료 후 Step 4 마무리 멘트를 전달한다

## 세션 관리 안내

Step 4 완료 후 다음 메시지를 전달한다:

> "Step 4가 완료되었어요! 🎉 나만의 스킬을 만들고 PR까지 제출했네요. 대단해요!
> **팁**: Step 5는 전체 온보딩을 회고하는 단계예요. 새 세션에서 시작하면 더 좋은 회고를 할 수 있어요.
> `/clear` 또는 새 터미널에서 `/onboarding 이어하기`로 시작하세요.
> 물론 지금 바로 이어서 진행해도 괜찮아요!"
