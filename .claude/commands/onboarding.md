---
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Agent, AskUserQuestion, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Slack__slack_send_message, mcp__claude_ai_Slack__slack_read_channel, mcp__claude_ai_Google_Calendar__gcal_list_events
description: 신규입사자 온보딩 시작. 사용법 - /onboarding, /onboarding 이어하기, /onboarding [닉네임] [직무] [팀]
---

# 온보딩 시작

온보딩 에이전트에게 위임합니다.

사용자 입력: $ARGUMENTS

에이전트 파일 `.claude/agents/onboarding-agent.md`를 읽고, 해당 에이전트의 지시에 따라 온보딩을 진행하세요.

인자가 없으면 닉네임/직무/팀을 물어보고 시작합니다.
"이어하기"가 포함되면 Notion 칸반 상태를 확인하여 진행 중인 Step부터 이어갑니다.
