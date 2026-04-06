# Phase 2: MCP 커넥터 연결

## EXPLAIN

### MCP(Model Context Protocol)란?

MCP는 Claude Code가 외부 도구와 연결되는 방법입니다.
쉽게 말하면, Claude Code에 "손"을 달아주는 것입니다.

MCP 커넥터를 연결하면 Claude Code가:
- **Notion**: 문서를 읽고, 페이지를 수정하고, DB를 검색할 수 있습니다
- **Slack**: 채널 메시지를 읽고, 메시지를 보낼 수 있습니다
- **Gmail**: 메일을 읽고, 초안을 작성할 수 있습니다
- **Google Calendar**: 일정을 조회하고, 새 일정을 만들 수 있습니다

### 왜 연결해야 하나요?

이 온보딩에서는 Notion에서 회사 문서를 가져오고, Slack에서 채널을 확인하고,
Calendar에서 일정을 조회하는 실습이 포함되어 있습니다.
커넥터가 연결되어 있어야 이런 실습이 가능합니다.

---

## EXECUTE

> 이번 Phase에서는 🌐 **claude.ai 브라우저**와 🖥️ **Claude Code 터미널**을 사용합니다.

아래 순서대로 4개 커넥터를 연결해주세요:

1. 🌐 [claude.ai로 이동] **웹 브라우저에서** claude.ai에 접속하세요 (또는 Claude 앱을 열어도 됩니다)
2. **설정 > 커넥터** 메뉴로 이동하세요 (영문 UI인 경우 Settings > Integrations)
3. 아래 4개 서비스를 하나씩 연결합니다:

| 커넥터 | 연결 버튼 | OAuth 인증 |
|--------|----------|-----------|
| **Notion** | "Connect Notion" 클릭 | Notion 로그인 → 워크스페이스 접근 허용 |
| **Slack** | "Connect Slack" 클릭 | Slack 로그인 → 워크스페이스 접근 허용 |
| **Gmail** | "Connect Gmail" 클릭 | Google 계정 로그인 → 메일 접근 허용 |
| **Google Calendar** | "Connect Google Calendar" 클릭 | Google 계정 로그인 → 캘린더 접근 허용 |

> **처음에 입력한 회사 이메일 계정**으로 로그인하세요!
> 개인 계정으로 연결하면 회사 Notion/Slack에 접근이 안 됩니다.
>
> **에이전트 지시** (신규입사자에게 보여주지 않는 내부 메모):
> progress.json의 `email` 필드 값을 직접 보여주며 안내한다. 임의의 이메일 주소를 만들어내지 마세요.

> 💡 **추가 커넥터**: 위 4개는 온보딩 필수 커넥터예요. 이 외에도 GitHub, Linear, Figma 등 다양한 MCP 커넥터를 자유롭게 추가 연결할 수 있어요. 온보딩이 끝난 후 업무에 필요한 커넥터를 탐색해보세요!

4개 모두 연결이 끝나면 이 터미널로 돌아와서 "연결했어" 또는 "완료"라고 입력해주세요!

> ⚠️ **중요: 웹과 터미널의 MCP 인증은 별도입니다!**
> 🌐 claude.ai(웹)에서 커넥터를 연결해도, 🖥️ Claude Code(터미널)에서 바로 사용되지 않을 수 있어요.
> 웹에서 연결을 완료한 후 **Claude Code를 재시작**(`/exit` → `claude`)해야 터미널에서 인식됩니다.

> 이후 Claude가 연결 상태를 확인할 때 **브라우저 인증 팝업**이 뜰 수 있어요. "Allow" 또는 "허용"을 클릭하면 됩니다. (커넥터별로 한 번만 하면 돼요)

### 연결 트러블슈팅

- **"커넥터가 안 보여요"**: Claude.ai에서 설정 > 커넥터(영문: Settings > Integrations)가 맞는지 확인. Claude 앱 버전이 최신인지 확인
- **"인증 화면이 안 떠요"**: 브라우저 팝업 차단 확인. Safari보다 Chrome 권장
- **"연결했는데 에러 나요"**: `/exit` 후 `claude`로 재시작. 재시작 후 `/mcp`로 연결 상태 확인
- **"터미널에서 인증 팝업이 안 떠요"**: Claude Code를 재시작(`/exit` → `claude`)한 후 다시 시도. 브라우저가 기본 브라우저로 설정되어 있는지 확인
- **"회사 Notion이 안 보여요"**: 개인 계정이 아닌 회사 계정(`@teamspace.io` 도메인)으로 로그인했는지 확인

---

## CHECK

- 질문: "4개 커넥터 연결을 완료했나요?"
- "연결이 잘 됐는지 확인해볼게요!" 라고 안내한 후 4개 커넥터를 자동으로 검증한다

> **에이전트 지시** (신규입사자에게 보여주지 않는 내부 메모):
> 아래 4개 MCP를 호출하여 연결 상태를 검증한다:
> 1. Notion: `notion-search`로 "Onboarding" 검색 → 결과 반환 확인
> 2. Slack: `slack_read_channel`로 `#00-collabo-announcements` 조회 → 메시지 확인
> 3. Gmail: `gmail_search_messages`로 최근 메일 조회 → 메일 확인
> 4. Calendar: `gcal_list_events`로 이번 주 일정 조회 → 일정 확인

- 검증 결과를 신규입사자에게 보여주며 피드백:
  - ✅ 연결 성공: "Notion ✅ — 온보딩 페이지가 잘 보여요!"
  - ❌ 연결 실패: 위 트러블슈팅 안내
- 최소 **Notion + Slack**은 필수. 나머지는 나중에 연결해도 OK.
- 전부 실패 시: HR Lead(Dana)에게 Slack DM으로 도움 요청 안내.
