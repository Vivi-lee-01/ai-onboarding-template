# [Step.0] 환경 설정 (클로드 코드 & 온보딩 레포 가져오기)

> ℹ️ Claude Code는 자주 업데이트됩니다. 화면이 이 가이드와 조금 다를 수 있지만, 핵심 흐름은 동일합니다.
> 막히면 HR({{HR_LEAD}})에게 슬랙 DM 주세요!

> 입사 전 또는 입사 당일에 이 가이드를 따라 Claude Code를 설치하고 업무 도구를 연결해주세요.
> 설정이 끝나면 터미널에서 `/onboarding`을 입력하여 온보딩을 시작합니다.

---

## 0. 왜 Claude Code로 온보딩을 하나요?

기존에는 Notion 문서를 혼자 읽고 체크리스트를 직접 체크하는 방식이었습니다.
Claude Code 온보딩은 다릅니다:

- AI가 단계별로 안내하고, 궁금한 것을 바로 질문할 수 있습니다
- 실제 업무 도구를 직접 조작해보며 배웁니다
- 산출물을 함께 만들면서 이해도를 확인합니다

---

## 1. Claude Code란?

Claude Code는 터미널에서 AI와 대화하며 업무를 처리하는 도구입니다.
웹 브라우저에서 쓰는 Claude와 같은 AI지만, **터미널(Terminal)**에서 실행되기 때문에:

- 파일을 직접 읽고/쓰고/수정할 수 있습니다
- 명령어를 실행할 수 있습니다
- Notion, Slack, Gmail, Calendar 등 업무 도구와 연동할 수 있습니다

{{COMPANY_NAME}}에서는 Claude Code를 **업무 파트너**로 사용합니다.

---

## 2. 설치 방법

### Mac

**Step 1:** Spotlight(`Cmd + Space`)에서 **Terminal** 검색 후 실행

**Step 2:** 터미널에 아래 명령어를 복사-붙여넣기 후 Enter

```
curl -fsSL https://claude.ai/install.sh | bash
```

**Step 3:** 설치 완료 후 `claude` 입력하여 실행

### Windows

**Step 1:** 시작 메뉴에서 **PowerShell** 검색 후 실행

**Step 2:** PowerShell에 아래 명령어를 복사-붙여넣기 후 Enter

```
npm install -g @anthropic-ai/claude-code
```

**Step 3:** 설치 완료 후 `claude` 입력하여 실행

> Windows는 Node.js 18 이상이 필요합니다. 설치되어 있지 않다면 [nodejs.org](http://nodejs.org)에서 먼저 설치하세요.

### 공통 (로그인 + 설정)

**Step 4:** `claude`를 실행하면 로그인 방식을 선택하는 화면이 나옵니다

1. **"How would you like to authenticate?"** 질문이 나오면
   → **Claude App (claude.ai)** 를 선택하세요 (API Key가 아닙니다!)
2. 브라우저가 자동으로 열리면 **회사 계정(`@{{COMPANY_DOMAIN}}`)**으로 로그인
3. **"Choose your plan"** 또는 조직 선택 화면이 나오면
   → **{{COMPANY_NAME_EN}} (Team plan)** 을 선택하세요
   → ⚠️ "API" 또는 "개인 플랜"을 선택하면 과금이 개인에게 갑니다!
4. 브라우저에 "Authorization successful" 메시지가 뜨면 터미널로 돌아옵니다

> 💡 화면 문구가 다를 수 있어요 — "Organization", "Workspace" 등으로 표시될 수도 있습니다.
> 핵심은 **{{COMPANY_NAME_EN}}**이 포함된 옵션을 선택하는 것!

> 계정이 없다면 HR팀({{HR_LEAD}})에게 Slack DM으로 문의하세요.
> Anthropic 팀 플랜 초대는 입사 전 HR이 미리 보내드립니다.

**Step 5:** 모델과 기본 모드를 설정합니다

Claude Code의 기본 모델은 Sonnet인데, **Opus로 바꾸면 훨씬 풍부하고 정확한 응답**을 받을 수 있어요.
Claude Code 안에서 아래와 같이 입력하세요:

```
모델을 opus로 바꾸고, 기본 권한 모드를 auto로 설정해줘
```

Claude가 `settings.json`을 자동으로 수정해줍니다.

> 💡 기본 모드를 auto로 설정하면 **매 세션마다 모드를 전환할 필요가 없어요.** 온보딩 레포에서 Claude를 실행하면 바로 Opus + Auto mode로 시작됩니다.

**Step 6:** Claude Code 안에서 `/output-style` 명령어를 입력합니다

1. 스타일 목록이 나오면 **Explanatory** 를 선택
2. 선택 후 "Output style set to explanatory" 메시지가 나오면 완료

---

## 3. 온보딩 레포 가져오기

온보딩 프로그램은 GitHub 레포지토리에 들어있습니다. 터미널에서 아래 명령어를 복붙하고 실행하세요 (Enter 누르기)

```
git clone --depth 1 https://github.com/{{GITHUB_ORG}}/onboarding-template.git
cd onboarding-template
claude
```

> 이 레포 안에서 Claude Code를 실행해야 `/onboarding` 명령어가 동작합니다!

---

## 4. 온보딩 시작하기

레포 폴더에서 Claude Code가 실행된 상태에서 `/onboarding`을 입력하세요.
AI가 가이드하는 인터랙티브 온보딩이 시작됩니다!

> 업무 도구 연결(Notion, Slack, Gmail, Calendar)은 온보딩 프로그램 안에서 Claude가 단계별로 안내해줍니다.
> 💡 OAuth 인증 화면도 업데이트에 따라 달라질 수 있습니다. "허용/Allow" 버튼의 위치나 문구가 다르더라도 **회사 계정(`@{{COMPANY_DOMAIN}}`)으로 로그인 → 권한 허용**의 흐름은 동일합니다.

---

> 📖 공식 설치 가이드: https://docs.anthropic.com/ko/docs/claude-code/setup
> 설치에 어려움이 있으면 HR팀({{HR_LEAD}})에게 Slack DM으로 문의하세요.
