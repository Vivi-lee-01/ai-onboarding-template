# Phase 3: 구현 + eval + Git PR

## EXPLAIN

### 구현 + eval + Git PR 워크플로우 3단계

Phase 2에서 초안을 잡았으니, 이제 완성하고 세상에 내보낸다.

**1단계: SKILL.md 완성**

Claude와 페어 프로그래밍으로 작성한다. Phase 2 초안을 발전시키면 된다.
- frontmatter가 정확한가?
- 실행 단계가 빠짐없이 있는가?
- 산출물이 명확한가?

Claude에게 "이 SKILL.md를 리뷰해줘"라고 요청하면 개선점을 잡아준다.

**2단계: evals 작성**

`evals/evals.json`에 최소 3개의 테스트를 작성한다:

```json
[
  {
    "name": "스킬명-core",
    "description": "핵심 동작 검증",
    "prompt": "/스킬명",
    "assertions": ["핵심 동작이 수행되어야 한다"]
  },
  {
    "name": "스킬명-quality",
    "description": "출력 품질 검증",
    "prompt": "특정 입력으로 스킬 실행",
    "assertions": ["출력 형식이 올바르다", "필수 정보가 포함된다"]
  },
  {
    "name": "스킬명-error",
    "description": "에러 대응 검증",
    "prompt": "잘못된 입력으로 스킬 실행",
    "assertions": ["에러 메시지가 친절하다", "다음 행동을 안내한다"]
  }
]
```

**3단계: Git + PR**

만든 스킬을 **[`new-lakler-first-skills`](https://github.com/teamspace-ai-all/new-lakler-first-skills)** 레포에 PR로 제출한다. 이 레포는 신규입사자들의 첫 스킬이 모이는 갤러리다.

> 📖 **먼저 읽기**: Notion의 **GitHub 사용 가이드**를 먼저 읽어보세요!
> Claude에게 "GitHub 사용 가이드 Notion 페이지 보여줘"라고 요청하면 됩니다. (`github_guide` ID: `32cc7a52db4f81ffa77bec3002686073`)
> Git/PR의 전체 흐름을 그림과 함께 설명해놓았으니, 아래 단계를 진행하기 전에 꼭 읽어주세요.

### Git/PR이 왜 필요한가요?

Git과 PR은 개발자만의 도구가 아닙니다. **AI Native 조직의 지식 관리 인프라**입니다.
팀스페이스의 `teamspace-ai-all` 레포에 모든 직원의 스킬이 쌓이면, 내가 만든 스킬을 다른 팀이 쓰고, 다른 팀이 만든 스킬을 내가 쓸 수 있습니다. 이 **복리 효과**가 Git/PR을 배우는 이유입니다.

**그리고 Git 명령어를 외울 필요가 전혀 없습니다.** Claude Code가 전부 대신 해줍니다!

### 핵심 개념 30초 정리

- **브랜치(branch)**: 원본을 건드리지 않고 내 작업 공간을 따로 만드는 것. 실험실 같은 개념.
- **커밋(commit)**: "여기까지 완성"이라고 저장 버튼을 누르는 것. 게임의 세이브 포인트.
- **PR(Pull Request)**: "제가 이거 만들었는데 봐주세요"라고 리뷰를 요청하는 것. 결재 올리기와 비슷.

### 사전 준비: GitHub org 초대 수락

HR에서 미리 GitHub 계정을 `teamspace-ai-all` org에 초대해두었습니다.

1. 회사 이메일(`@teamspace.io`)의 받은편지함에서 **"You've been invited to join teamspace-ai-all"** 메일을 찾으세요
2. 메일이 안 보이면 **스팸함/프로모션 탭**도 확인하세요
3. 그래도 없으면 HR(Dana)에게 Slack DM으로 "GitHub org 초대 메일 재발송 부탁드립니다"라고 요청하세요
4. 초대 링크를 클릭하고 **Accept invitation**을 누르면 완료!

### gh auth login (GitHub 인증)

PR을 만들려면 먼저 GitHub에 로그인해야 합니다. Claude에게 이렇게 말하세요:

> "gh auth login 진행해줘"

Claude가 터미널에서 단계별로 안내해줍니다. 선택지가 나오면:
- `GitHub.com` 선택
- `HTTPS` 선택
- `Login with a web browser` 선택 → 브라우저에서 코드 입력하면 끝!

만약 에러가 나면 Claude에게 에러 메시지를 그대로 보여주세요. 해결 방법을 안내해줍니다.

### 브랜치 → 커밋 → PR (Claude가 다 해줍니다)

아래 명령어를 직접 칠 필요 없습니다! Claude에게 이렇게 말하면 됩니다:

> "new-lakler-first-skills 레포에 내 스킬 커밋하고 PR 만들어줘"

Claude가 알아서 다음을 수행합니다:

```bash
# 0. 제출 대상 레포 클론
git clone https://github.com/teamspace-ai-all/new-lakler-first-skills.git
cd new-lakler-first-skills

# 1. 브랜치 생성 — 내 작업 공간 만들기
git checkout -b feat/닉네임-스킬명

# 2. 스킬 파일을 submissions 폴더에 복사
mkdir -p submissions/닉네임/스킬명
# SKILL.md, references/, evals/ 를 복사

# 3. 커밋 — 저장 버튼 누르기
git commit -m "feat: 닉네임의 첫 스킬 — 스킬명"

# 4. PR 생성 — 리뷰 요청 올리기
gh pr create --title "feat: 닉네임의 첫 스킬 — 스킬명" --body "스킬 설명..."
```

> 💡 **기억하세요**: 위 명령어를 외우거나 직접 입력할 필요 없습니다.
> Claude에게 "커밋하고 PR 만들어줘"라고 말하면 전 과정을 대신 해줍니다.
> 혹시 막히면 "지금 상태가 어떤지 확인해줘" (`git status`)라고 물어보세요.

## EXECUTE

다음 순서대로 진행하세요:

**1. SKILL.md 완성**
Phase 2에서 만든 초안을 Claude와 함께 완성하세요.
Claude에게 "이 SKILL.md를 리뷰해줘"라고 요청해서 피드백을 받으세요.

**2. evals/evals.json 작성**
최소 3개: 핵심 워크플로우(1) + 출력 품질(1) + 에러 케이스(1)
Claude에게 "이 스킬에 맞는 eval을 만들어줘"라고 요청할 수 있습니다.

**3. 실행 테스트**
`/내스킬명`을 실행해서 실제로 동작하는지 확인하세요.

**4. Git: 브랜치 → 커밋 → PR**
Claude에게 "new-lakler-first-skills 레포에 내 스킬 커밋하고 PR 만들어줘"라고 요청하면 전 과정을 도와줍니다.

**5. Slack에서 GitHub Notifications 앱 설치**
PR을 올렸으니, 리뷰 댓글이나 머지 알림을 Slack에서 받을 수 있도록 설정하세요.
- Slack 좌측 하단 > **앱** > "GitHub" 검색 > **추가**
- 추가 후 DM으로 `/github subscribe teamspace-ai-all/new-lakler-first-skills` 입력하면 알림 연동 완료

## CHECK

**확인 1**: "만든 스킬을 동료에게 한 문장으로 소개한다면?"
- 기대: 스킬의 가치가 명확하게 전달되면 OK. "이 스킬은 ~를 자동화해서 ~를 줄여준다" 형태가 이상적

**확인 2**: "다음에 이 스킬에 추가하고 싶은 기능이 있다면?"
- 기대: 어떤 답이든 OK. "스킬은 계속 발전시킬 수 있다"는 마인드셋 확인
