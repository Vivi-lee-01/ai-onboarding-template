# content/ — 온보딩 공용 콘텐츠 로컬 사본

이 폴더의 `.md` 파일들은 **Notion 원본의 로컬 사본**입니다.
신규입사자 온보딩 세션은 여기를 즉시 Read하여 콘텐츠를 전달합니다 (런타임 Notion fetch 없음).

- **원본(편집처)**: Notion. 페이지 ID는 `config/notion-ids.json`.
- **갱신 방법**: Notion에서 콘텐츠를 고친 뒤 Claude Code에서 `/sync-content` 1회 실행.
- 각 파일 상단 frontmatter의 `source_notion_id`·`synced_at`로 출처/시점을 확인.
- 이 폴더는 파생물입니다. 직접 손으로 고치지 말고 Notion에서 고친 뒤 sync 하세요.
