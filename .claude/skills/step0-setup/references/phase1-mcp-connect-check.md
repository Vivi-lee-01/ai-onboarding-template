# Phase 2: MCP 커넥터 연결

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
