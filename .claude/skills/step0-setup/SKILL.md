---
name: step0-setup
description: "Step 0 환경 설정 - MCP 커넥터 연결, 온보딩 시작 준비. 트리거: 'Step 0', '설치', 'setup', '환경 설정'"
---

# Step 0: 환경 설정

> 업무 도구(Notion, Slack, Gmail, Calendar)를 Claude Code에 연결하는 단계.

## 전제 조건

Claude Code 설치와 레포 clone은 이 프로그램 실행 전에 완료되어 있어야 한다.
설치 가이드는 Notion [Step.0] 환경 설정 카드에 별도 문서로 제공된다 (온보딩 프로그램 범위 밖).

## 산출물

없음 — 연결 확인만 수행.

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

## References 파일 맵

| Phase | 파일 | 내용 |
|-------|------|------|
| Phase 0 | `references/phase0-roadmap.md` | 온보딩 로드맵 — 전체 일정, 산출물, 오프라인 터치포인트 |
| Phase 1 | `references/phase1-mcp-connect.md` | MCP 커넥터 연결 (Notion/Slack/Gmail/Calendar) |
| Phase 2 | `references/phase2-claude-tips.md` | Claude Code 사용 팁 — Output Style, 상태바, 모드, 컨텍스트 압축 |
| Phase 3 | `references/phase3-settings-optimization.md` | 나만의 세팅 — CLAUDE.md, settings.json, 플러그인 최적화 |
| Phase 4 | `references/phase4-github-leaderboard.md` | 사내 리더보드 등록 (collector 설치 + 자동 수집) |

## Phase 1 특별 규칙: 연결 먼저 → 확인 실습

Phase 1(MCP 연결)은 2단계로 나뉘지만, **총 2턴(Phase A + Phase B)으로 완료**한다:

**Phase A (첫 번째 턴)**:
1. EXPLAIN 섹션 전체를 설명한다 (MCP 개념 + 4개 커넥터 역할)
2. EXECUTE의 **Step 1(커넥터 연결하기)** + **Step 2(확인 실습 4개를 한꺼번에)** 안내한다
3. "4개 커넥터를 연결하고, 확인 실습까지 해보세요"라고 안내한다 → STOP

**Phase B (두 번째 턴)**:
4. 신규입사자가 돌아오면 CHECK 섹션으로 완료 확인
5. 일부 미연결이면 트러블슈팅 후 다음으로 넘어간다

이 방식을 사용하는 이유: 커넥터 연결 없이 실습을 시도하면 에러가 나서 신규입사자가 당황함.
확인 실습 4개는 각각 한 줄 명령어이므로 한 턴에 안내해도 부담이 적다.

## 진행 흐름

스킬이 시작되면:
1. 환영 인사 + Step 0의 목표를 간단히 안내한다
2. **Phase 0(로드맵)**: references/phase0-roadmap.md를 읽고 전체 온보딩 여정을 보여준다
   - 이 Phase도 STOP PROTOCOL(Phase A → Phase B)을 따른다
   - Phase A: EXPLAIN(로드맵 설명) + EXECUTE("확인했어"를 기다림) → STOP
   - Phase B: CHECK(궁금한 점 확인) → 다음으로
3. **Phase 1(MCP 연결)**: references/phase1-mcp-connect.md를 읽고 STOP PROTOCOL에 따라 진행
   - Phase 1은 위의 "Phase A/B 2턴 완료" 규칙을 따른다
4. **Phase 2(Claude Code 사용 팁)**: references/phase2-claude-tips.md를 읽고 STOP PROTOCOL에 따라 진행
   - 상태바 확인, 모드 전환, `/compact` 체험을 직접 실행하게 한다
5. **Phase 3(나만의 세팅)**: references/phase3-settings-optimization.md를 읽고 STOP PROTOCOL에 따라 진행
   - CLAUDE.md 확인, `/plugins`로 플러그인 정리를 직접 실행하게 한다
6. **Phase 4(리더보드)**: references/phase4-github-leaderboard.md를 읽고 STOP PROTOCOL에 따라 진행
   - 사내 리더보드 사이트 로그인 → collector 설치 → 첫 수집 → launchd 자동 수집 전환 안내
7. Phase 4 완료 후 Step 0 마무리 멘트 + Step 1 안내

## 세션 관리 안내

Step 0 완료 후 다음 메시지를 전달한다:

> "Step 0이 완료되었어요! 🎉
> 방금 설정한 Output Style, 상태바 등은 **새 세션부터 적용**됩니다.
> `/clear`를 입력하거나 새 터미널을 열고 `/onboarding 이어하기`로 시작하세요!
> 그러면 Step 1부터 ★ Insight와 함께 온보딩이 진행돼요."

## MCP 토큰 관리 팁

Step 0 마무리 시 아래 팁도 함께 안내한다:

> "💡 **MCP 토큰 절약 팁**: 4개 MCP를 전부 켜두면 Claude의 '생각할 공간'이 줄어들어요.
> 각 Step에서 필요한 커넥터만 켜두면 더 정확한 응답을 받을 수 있어요.
> `/mcp`로 커넥터를 켜고 끌 수 있고, `/context`로 현재 사용량을 확인할 수 있어요.
>
> **Step별 주로 사용하는 MCP:**
> - Step 1~3: Notion (필수), Slack (Phase별)
> - Step 4: 거의 불필요 (로컬 작업 중심)
> - Step 5: Notion + Slack
> - Step 6: Notion"
