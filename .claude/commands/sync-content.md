---
allowed-tools: Read, Write, Bash, Glob, mcp__claude_ai_Notion__notion-fetch
description: Notion 콘텐츠 페이지를 content/ 로컬 사본으로 동기화. 사용법 - /sync-content [키] (키 생략 시 전체)
---

# 콘텐츠 동기화 (Notion → content/)

온보딩 공용 읽기 콘텐츠의 로컬 사본을 Notion 원본에서 갱신한다.
**세션 밖에서 운영자(Dana)가 콘텐츠를 수정한 뒤 실행하는 도구.** 신규입사자 세션에서는 호출하지 않는다.

사용자 입력: $ARGUMENTS

## 동기화 대상 (키 → 파일)

`config/notion-ids.json`을 읽어 아래 키만 동기화한다 (개인 read-write 페이지·구조 키 제외):

| 키 | content/ 파일 |
|----|------|
| step1_general | content/step1-general.md |
| step2_product | content/step2-product-guide.md |
| step3_biz | content/step3-biz.md |
| step6_live_audit | content/step6-live-audit.md |
| github_guide | content/github-guide.md |

> **링크 전용(동기화 안 함)**: `heyground_guide`·`flex_guide`는 에이전트가 본문을 읽지 않고 신규입사자가 브라우저로 여는 외부 안내 링크라 content/로 동기화하지 않는다(references는 URL만 사용). `culture_deck`은 PDF라 브라우저 open 전용. `onboarding_db`·`onboarding_parent`는 쓰기/구조 키, `general_home`은 스킬/agent 미참조라 제외.
> ⚠️ 2026-06-02 첫 sync 시 `heyground_guide` ID(`516c7a52...`)는 Notion 404 — 페이지 ID stale 또는 통합 미공유. 링크 전용이라 무영향이나, 콘텐츠로 쓰려면 ID·공유 점검 필요.

## 절차

1. `$ARGUMENTS`에 특정 키가 있으면 그 키만, 없으면 위 표 전체를 대상으로 한다.
2. `config/notion-ids.json`을 읽어 각 키의 페이지 ID를 얻는다.
3. 각 페이지를 `notion-fetch`로 가져온다.
   - fetch 실패 시: 해당 파일은 **건드리지 않고**(기존 사본 보존) 실패 목록에 기록, 다음 키로 진행.
4. 가져온 내용을 `content/{파일}`에 Write한다. 파일 맨 앞에 frontmatter를 붙인다:
   ```
   ---
   source_notion_id: "{페이지 ID}"
   synced_at: "{오늘 날짜 YYYY-MM-DD}"
   source: notion
   ---
   ```
   (날짜는 사용자에게 묻거나 시스템 컨텍스트의 today's date를 사용)
5. 완료 후 요약을 출력한다:
   - 갱신된 파일 목록 + 각 synced_at
   - 실패한 키 목록 (있으면)
   - "git add content/ 후 커밋하면 사본 버전이 추적됩니다" 안내 (커밋은 사용자 판단)

## 안전 규칙

- 단방향(Notion → 로컬)만. 로컬 → Notion 역방향 쓰기는 절대 하지 않는다.
- Notion이 항상 진실 원본. content/는 파생물.
- fetch 실패가 기존 사본을 덮어쓰지 않게 한다.
