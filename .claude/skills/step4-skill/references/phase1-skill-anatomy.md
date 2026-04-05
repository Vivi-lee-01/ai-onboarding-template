# Phase 1: 스킬 해부 — 구조와 동작 원리

## EXPLAIN

### 스킬이란?

슬래시 명령어 하나로 복잡한 업무를 자동화하는 레시피다.

Claude Code에서 `/스킬이름`을 입력하면 SKILL.md가 로드되고, Claude가 그 안의 지시를 따라 업무를 수행한다. 마치 요리 레시피처럼 — 재료(입력)와 조리법(단계)이 정해져 있으면 누구든 같은 결과물을 만들 수 있다.

공식 문서: https://docs.anthropic.com/ko/docs/claude-code/skills

### SKILL.md 구조

스킬 폴더는 3가지로 구성된다:

**1. SKILL.md — 스킬의 핵심**
- **frontmatter**: `name`과 `description` 필드. Claude가 스킬을 찾고 매칭하는 데 사용한다.
  ```yaml
  ---
  name: my-skill-name
  description: "이 스킬이 하는 일을 한 줄로 설명"
  ---
  ```
- **본문**: 프로토콜(규칙), 실행 단계, 산출물 정의 등. Claude가 따라야 할 지시사항 전부.

**2. references/ — 참조 파일**
- 상세 가이드, 데이터, 템플릿 등을 별도 파일로 분리해둔다.
- SKILL.md가 너무 길어지는 것을 방지하고, 필요한 Phase에서만 읽어오는 구조.

**3. evals/evals.json — 검증 테스트**
- 스킬이 제대로 동작하는지 검증하는 테스트. 최소 3개 필수.
- 핵심 워크플로우(1) + 출력 품질(1) + 에러/엣지케이스(1)

### 실제 예시

이 온보딩 캠프의 Step 0~3 스킬이 바로 스킬이다! `/step1-general`을 실행하면 Claude가 SKILL.md를 읽고, references 파일을 Phase별로 불러와서, STOP PROTOCOL에 따라 가이드해주는 것 — 이 모든 것이 스킬의 동작이다.

## EXECUTE

Claude에게 다음 중 하나를 해보세요:

1. **이 캠프 스킬 구조 복습**: "step1-general 스킬의 SKILL.md를 보여줘"
2. **다른 실전 스킬 분석**: 이미 설치된 스킬이 있다면 "내 스킬 목록 보여줘"

분석할 때 이 포인트를 살펴보세요:
- frontmatter는 어떻게 생겼나? name과 description에 뭐가 들어있나?
- STOP PROTOCOL은 왜 있나? 없으면 어떻게 될까?
- references 폴더에는 어떤 파일들이 있고, 어떤 역할을 하나?

## CHECK

**확인 1**: "SKILL.md의 필수 구성요소 3가지를 말해주세요."
- 기대: (1) frontmatter (name + description), (2) 본문 (프로토콜 + 단계), (3) evals (검증 테스트)

**확인 2**: "references 폴더는 왜 필요한가요? SKILL.md에 다 쓰면 안 되나요?"
- 기대: 길이 관리 + 필요한 Phase에서만 선택적 로드 → 효율성. 어떤 방향으로든 "분리의 이유"를 설명하면 OK
