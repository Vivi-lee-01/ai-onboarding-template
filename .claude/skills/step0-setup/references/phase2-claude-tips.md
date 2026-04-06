# Phase 2: Claude Code 사용 팁

## EXPLAIN

### 앞으로 이 도구를 매일 쓰게 됩니다

MCP 연결을 마쳤으니, 이제 Claude Code를 **잘 쓰는 법**을 알아볼 차례예요.

온보딩 전 과정이 이 터미널에서 진행되고, 온보딩이 끝나도 업무에서 계속 사용하게 되니까 지금 익혀두면 좋아요!

### 1. Output Style 설정

Claude Code는 **Output Style**이라는 설정으로, 코드를 작성할 때 왜 이렇게 했는지 ★ Insight로 설명도 같이 해줄 수 있어요.

| 스타일 | 설명 |
|--------|------|
| **Default** | 기본. 효율적으로 코딩만 함 |
| **Explanatory** | 코드 작성 시 ★ Insight 교육적 설명 추가 |
| **Learning** | Insight + 의미 있는 코드를 직접 작성해보게 유도 |

> **Explanatory** 또는 **Learning** 스타일을 추천해요! Claude가 하는 일을 이해하면서 배울 수 있습니다.

### 2. 하단 상태바 설정

Claude Code는 터미널 맨 아래에 **상태바**를 표시할 수 있어요.
기본 설치 상태에서는 보이지 않지만, `/statusline` 명령어로 간단하게 설정할 수 있습니다.

상태바를 설정하면 이런 정보를 한눈에 볼 수 있어요:
- **컨텍스트 사용량**: 대화가 길어질수록 올라감 (예: `45%`)
- **예측 비용**: 이 세션에서 사용한 토큰 비용
- **현재 모드**: Ask permissions / Auto accept edits / Plan mode

### 3. 컨텍스트와 자동 압축

Claude는 한 세션에서 기억할 수 있는 양이 정해져 있어요 (컨텍스트).
대화가 길어지면 컨텍스트가 차게 되는데, **걱정하지 마세요!**

- 컨텍스트가 가득 차면 **Claude가 자동으로 이전 대화를 요약·압축**합니다
- 대화가 끊기거나 멈추지 않아요 — 자연스럽게 이어집니다
- 그래도 새 주제를 시작할 때는 새 세션(`/clear`)이 더 좋아요

### 4. 모드

Claude Code에는 몇 가지 **모드**가 있어요:

| 모드 | UI 표시 | 설명 | 전환 방법 |
|------|---------|------|-----------|
| 기본 | **Ask permissions** | 매번 실행 전에 허락을 물어봄 | 기본값 |
| 편집 자동 | **Auto accept edits** | 파일 읽기/편집은 자동, 명령어만 물어봄 | `Shift+Tab` |
| 계획 | **Plan mode** | 실행 않고 계획만 세움 | `Shift+Tab` 두 번 |
| 자동 | **Auto mode** | 모든 작업을 자동으로 실행 (중단 없이 쭉 진행) | `claude --enable-auto-mode` |

> `Shift+Tab`은 **Ask permissions ↔ Auto accept edits ↔ Plan mode** 사이를 순환해요.
> **Auto mode**는 별도로, 세션 시작 시 `claude --enable-auto-mode` 명령어로 활성화해야 합니다.
>
> 온보딩 중에는 **Auto mode**를 권장해요! Claude가 끊김 없이 자연스럽게 안내해줍니다.

---

## EXECUTE

### 여러분이 할 일

아래 5가지를 직접 해보세요!

**1. Output Style 설정하기**
- 아래 명령어를 입력해보세요:
  ```
  /config
  ```
- **Output style** 항목을 선택하세요
- **Explanatory** 또는 **Learning**을 선택하면, Claude가 코드를 작성할 때 ★ Insight로 교육적 설명도 함께 해줍니다
- 설정은 다음 세션부터 적용돼요!

**2. 상태바 설정하기**
- 아래 명령어를 입력해보세요:
  ```
  /statusline 컨텍스트 사용량, 비용, 현재 모드를 보여줘
  ```
- Claude가 자동으로 상태바 스크립트를 만들어줍니다
- 터미널 맨 아래에 상태바가 나타나는지 확인해보세요!

**3. 컨텍스트 사용량 확인하기**
- 아래 명령어를 입력해보세요:
  ```
  /context
  ```
- 현재 컨텍스트 사용량이 표시돼요

**4. 모드 전환 해보기**
- `Shift+Tab`을 눌러보세요 → **Auto accept edits**로 전환됩니다
- 다시 `Shift+Tab`을 눌러보세요 → **Plan mode**로 전환됩니다
- 한 번 더 `Shift+Tab` → 다시 **Ask permissions**로 돌아와요
- **Auto mode**를 쓰려면: 이 세션을 `/exit`으로 종료하고, `claude --enable-auto-mode`로 재시작하세요
- 온보딩 중에는 **Auto mode** 권장!

**5. 대화 압축 체험하기**
- 아래 명령어를 입력해보세요:
  ```
  /compact
  ```
- Claude가 지금까지의 대화를 요약합니다
- 컨텍스트가 가득 차면 이게 자동으로 실행돼요!

5가지를 다 해봤으면 "완료" 또는 "다음"이라고 입력해주세요!

---

## CHECK

- 질문: "Output Style, 상태바, 모드 설정이 잘 됐나요?"
- 각 항목 확인:
  - `/config`에서 Output Style을 설정했는지 (Explanatory 또는 Learning 권장)
  - `/statusline`으로 상태바가 설정되었는지
  - `Shift+Tab` 모드 순환을 해봤는지, Auto mode(`claude --enable-auto-mode`)를 이해했는지
  - `/compact` 실행 결과를 봤는지
- "앞으로 컨텍스트가 차도 당황하지 마세요. Claude가 자동으로 처리합니다!"
- 궁금한 점이 있으면 답변 후 Step 0 마무리로 진행
