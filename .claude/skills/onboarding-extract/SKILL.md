---
name: onboarding-extract
description: "온보딩 핵심 콘텐츠를 상시 참조용 MD로 추출. 온보딩 완료 후 실행. 트리거: '핵심 정리', '온보딩 추출', 'extract onboarding', '상시 참조'"
---

# 온보딩 핵심 콘텐츠 추출

> 온보딩(Step 1~5)에서 학습한 핵심 콘텐츠를 하나의 MD 파일로 추출하여,
> 신규입사자가 Claude Code를 사용하며 언제든 꺼내볼 수 있게 한다.

## 왜 필요한가

온보딩에서 배운 핵심 지식(컬쳐, BM, 고객여정, 프로덕트 구조 등)은 업무 중에도 항상 필요해요.
이 스킬은 그 지식을 하나의 파일로 정리해서, 앞으로 Claude Code를 쓸 때 회사 맥락을 자동으로 파악할 수 있게 해줍니다.

## 전제 조건

- Step 5(회고)까지 완료된 상태

## 산출물

`outputs/{닉네임}-{입사일}/onboarding-reference.md` — 업무 중 상시 참조할 수 있는 회사 핵심 정리 파일

## 진행 방식

이 스킬은 **자동으로 진행**됩니다. 별도의 실행 과제가 없어요!

1. Claude가 온보딩에서 배운 내용을 자동으로 수집합니다
2. 핵심 내용을 하나의 파일로 구조화합니다
3. 완성된 파일을 보여드리고, 수정할 부분이 있으면 반영합니다
4. 저장 후 Claude Code에서 참조하는 방법을 안내해드려요

## 추출 절차

### Phase 1: 콘텐츠 수집

1. `outputs/{닉네임}-{입사일}/` 폴더의 모든 산출물을 읽는다
2. 온보딩 references 파일들에서 핵심 팩트를 수집한다:
   - `step1-general/references/phase1-culture.md` → 핵심 가치, 일하는 방식
   - `step3-biz/references/phase1-bm.md` → BM 구조, 수익 모델
   - `step3-biz/references/phase3-team-deep-dive.md` → 팀별 역할
3. Notion에서 최신 정보를 MCP로 보충 (선택)

### Phase 2: 구조화

아래 구조로 MD 파일을 생성한다:

```markdown
# {닉네임}의 {{COMPANY_NAME}} 핵심 레퍼런스

> 이 파일은 온보딩에서 학습한 핵심 내용을 정리한 것입니다.
> Claude Code가 업무 컨텍스트를 이해하는 데 사용됩니다.

## 회사 개요
- {{COMPANY_NAME}} / {{SERVICE_NAME}}
- {자사 사업 분야 한 줄 설명}

## 핵심 가치 & 일하는 방식
(Step 1에서 학습한 컬쳐 요약)

## 비즈니스 모델
(Step 3에서 학습한 BM 요약 — 수익 구조, 경쟁 포지셔닝)

## 고객 여정
(Step 3에서 학습한 고객 유형, 레벨링, 핵심 터치포인트)

## 프로덕트 구조
(Step 2에서 체험한 서비스 제공자/이용자 관점 요약)

## 내 팀({팀명})의 역할
(Step 3 팀별 심화 + Step 5 킥오프 내용)

## 주요 도구 & 채널
- Slack 핵심 채널: #general, #{{CHANNEL_LIVE_MONITORING}}, ...
- Notion 핵심 페이지: ...
- 업무 도구: {{HR_SYSTEM}}, {{OFFICE_APP}}, ...
```

### Phase 3: 저장 + 연결 안내

1. `outputs/{닉네임}-{입사일}/onboarding-reference.md`로 저장
2. 신규입사자에게 안내:

> "온보딩 핵심 내용을 하나의 파일로 정리했어요!
> 이 파일을 Claude Code에서 상시 참조하려면, 홈 디렉토리의 CLAUDE.md에 아래 한 줄을 추가하세요:
> ```
> - 회사 레퍼런스: @{절대경로}/onboarding-reference.md
> ```
> 이렇게 하면 Claude가 업무 중에도 회사 맥락을 자동으로 파악해요."

## 내부 동작 (에이전트 지시)

> 이 섹션은 Claude가 참조하는 내부 메모입니다.

이 스킬은 Step 5 완료 후, 신규입사자가 동의하면 호출된다.

내부적으로 2단계로 진행한다:
1. **수집**: outputs 폴더 + references 파일에서 핵심 팩트를 수집 (Explore 에이전트 활용)
2. **구조화**: 수집된 팩트를 MD 파일로 생성
