# AI Interactive Onboarding Template

> "AI Native를 말하면서 AI Naive한 온보딩을 하고 있진 않나요?"

Claude Code 기반 **신규입사자 대화형 온보딩 템플릿**. 문서를 "읽는" 온보딩이 아니라, AI 에이전트와 7단계를 **함께 체험**하며 회사에 스며들게 만드는 방식입니다.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skills-8A63D2)](https://www.claude.com/claude-code)
[![Template](https://img.shields.io/badge/GitHub-Use%20this%20template-2ea44f)](https://github.com/Vivi-lee-01/ai-onboarding-template/generate)

📖 **만들게 된 이야기**: [AI Native를 말하면서 AI Naive한 온보딩을 하고 있었다](https://vivi-blog-three.vercel.app/posts/interactive-onboarding)

---

## 왜 이걸 만들었나

"AI Native 조직"이라고 말하면서 신규입사자에겐 PDF와 노션 문서를 한 뭉텅이 던져주고 있었습니다. **말과 경험이 일치하지 않는 모순**. 그래서 온보딩 자체를 "AI와 함께 일하는 법"을 체험하는 과정으로 새로 설계했습니다.

- **읽기 → 체험**: 문서 전달이 아니라 에이전트와 대화하며 진행
- **정적 → 실시간**: Notion 단일 소스에서 MCP로 즉시 fetch (이중 관리 제거)
- **완료 여부 → 이해도 기반**: 체크박스 대신 학습 리포트 자동 생성
- **혼자 → 연결**: Step 완료 시 담당자에게 자동으로 커피챗 DM 발송

---

## 가상 회사로 바로 체험해보세요

이 템플릿에는 **가상의 B2B SaaS 회사 "TeamSpace Inc."**의 콘텐츠가 채워져 있습니다. 플레이스홀더(`{{COMPANY_NAME}}`)가 아니라 실제 맥락이 있는 데이터이므로, clone 즉시 온보딩 데모를 체험할 수 있어요.

| 항목 | 가상 회사 설정 |
|------|--------------|
| **회사명** | TeamSpace Inc. (팀스페이스) |
| **서비스** | Collabo (콜라보) — 실시간 협업 도구 (화이트보드 + 프로젝트 보드) |
| **규모** | ~40명, 4개 팀 (Product/Growth/Engineering/Operations) |
| **BM** | SaaS 구독 (Free / Pro / Enterprise) |
| **HR Lead** | Dana |

> 자사에 적용할 때는 [`CUSTOMIZATION.md`](CUSTOMIZATION.md)를 참고하여 가상 회사 정보를 자사 정보로 교체하세요.

---

## 5분 Getting Started

### 1. 템플릿 사용
상단의 **[Use this template](https://github.com/Vivi-lee-01/ai-onboarding-template/generate)** 버튼 클릭 → 본인 조직에 새 레포 생성.

```bash
git clone https://github.com/YOUR_ORG/your-onboarding.git
cd your-onboarding
```

### 2. 실 설정 파일 생성
```bash
cp config/notion-ids.example.json config/notion-ids.json
cp config/team-leads.example.json config/team-leads.json
```
> `notion-ids.json`과 `team-leads.json`은 `.gitignore`에 등록되어 있어 **실수로 커밋되지 않습니다**.

### 3. 자사 정보로 커스터마이징
[`CUSTOMIZATION.md`](CUSTOMIZATION.md)의 가이드를 따라 가상 회사 정보를 자사 정보로 교체합니다.

### 4. 신규입사자에게 전달
```bash
# 신규입사자 로컬에서:
claude
# Claude Code 프롬프트:
/onboarding
```

---

## 온보딩 7단계

| Step | 이름 | 목표 | 산출물 |
|------|------|------|--------|
| **Step 0** | Setup | MCP 연결 + Claude Code 세팅 | - |
| **Step 1** | General | 회사 문화, 업무 도구 세팅, Slack 인사 | - |
| **Step 2** | Product | 자사 제품/서비스 체험 (개밥먹기) | Notion 체험 리포트 |
| **Step 3** | Biz | BM, 고객 여정, 시나리오 퀘스트 | - |
| **Step 4** | Build Your First Skill | 스킬 해부 → 설계 → 구현 → PR | GitHub PR |
| **Step 5** | Wrap Up | 회고 + 팀 킥오프 조언 | - |
| **Step 6** | Live Audit | 실서비스 참관 (선택) | 참관 리포트 |

### 시나리오 플로우

> 상세 다이어그램은 [`docs/onboarding-flow.md`](docs/onboarding-flow.md)에서 확인할 수 있습니다.

```mermaid
flowchart TD
    START(["/onboarding 실행"]) --> INIT["닉네임 / 직무 / 팀 입력<br/>Notion 칸반 카드 자동 생성"]

    INIT --> S0["🔧 Step 0 — 환경 설정<br/>Phase 0 로드맵 · Phase 1 MCP · Phase 2 팁 · Phase 3 세팅 · Phase 4 리더보드"]
    S0 --> S1["🏢 Step 1 — General Onboarding<br/>Phase 1 컬쳐덱 · Phase 2 도구 세팅 · Phase 3 Slack 인사"]
    S1 --> S2["📦 Step 2 — Product Onboarding<br/>Phase 0 조직 · Phase 1 제품 체험 · Phase 2 AI 개선안"]
    S2 -->|"☕ CPO 커피챗 DM"| S3["💼 Step 3 — Biz Onboarding<br/>Phase 0 조직 · Phase 1 BM · Phase 2 시나리오 · Phase 3 팀 심화"]
    S3 -->|"☕ CGO 커피챗 DM"| S4["🛠️ Step 4 — Build Your First Skill<br/>Phase 1 해부 · Phase 2 설계 · Phase 3 구현+PR"]
    S4 --> S5["🔄 Step 5 — Wrap Up<br/>Phase 1 회고+VoC · Phase 2 킥오프 조언"]
    S5 -->|"📨 VoC → HR Slack DM<br/>🔔 완료 알림 → 팀장+HR"| DONE(["✅ 온보딩 종료"])
    DONE -.->|"비동기 · 세션 일정에 맞춰"| S6["🎬 Step 6 — 실서비스 참관<br/>Phase 1 준비 → ⏸️ 참관 → Phase 2 리포트"]
    S6 --> FINAL(["🎉 온보딩 완주"])

    classDef stepNode fill:#f0f4ff,stroke:#4a6cf7,stroke-width:2px,color:#1a1a2e
    classDef actionNode fill:#fef3c7,stroke:#f59e0b,stroke-width:1px,color:#78350f
    classDef endNode fill:#d1fae5,stroke:#10b981,stroke-width:2px,color:#065f46

    class S0,S1,S2,S3,S4,S5,S6 stepNode
    class INIT actionNode
    class DONE,FINAL endNode
```

---

## 핵심 설계

### STOP PROTOCOL — 2턴 진행
모든 Phase는 "설명 후 멈춤 → 확인 후 다음"으로 강제됩니다.

```
턴 1 (Phase A): EXPLAIN → EXECUTE → ⛔ STOP
턴 2 (Phase B): CHECK → 피드백 → "다음으로 / 더 알아보기" 선택 → 다음 Phase
```

신규입사자가 **놓치는 정보 없이** 각 단계를 소화하게 만드는 장치입니다.
CHECK 후 "조금 더 알아보고 싶어요"를 선택하면 추가 질문/재실습 후 다시 진행할 수 있습니다.

### 자동화 기능
- **Notion 칸반 자동 업데이트**: Step 시작 시 "진행 중", 완료 시 "완료"로 자동 변경
- **Slack 자동 알림**: Step 완료 시 HR + 팀장/셀리드에게 DM 발송, 도메인 오너 커피챗 요청
- **피드백 PR 자동 수집**: 각 Step 종료 시 피드백을 수집하여 GitHub PR로 자동 제출
- **Notion 동적 참조**: 콘텐츠 하드코딩 대신 MCP로 실시간 fetch

### 설계 원칙
- **점진적 난이도**: 따라하기(Step 0~1) → 응용(Step 2~3) → 만들기(Step 4~5)
- **팀별 분기**: 소속 팀에 따라 시나리오, 스킬 아이디어, 심화 콘텐츠가 달라짐
- **비동기 지원**: Step 6은 일정에 맞춰 비동기 진행 (자동 리마인더 포함)

---

## 프로젝트 구조

```
.claude/
  agents/
    onboarding-agent.md       # 메인 에이전트 (전체 흐름 제어)
  skills/
    step0-setup/              # Claude Code 설치 + MCP 연결
    step1-general/            # 문화/도구/Slack 인사
    step2-product/            # 제품 체험
    step3-biz/                # BM, 고객여정, 시나리오 퀘스트
    step4-skill/              # 나만의 스킬 만들기
    step5-wrapup/             # 회고 + 팀 킥오프 조언
    step6-live-audit/         # 실서비스 참관 (선택)
config/
  notion-ids.example.json     # Notion 페이지 ID 매핑 (예시)
  team-leads.example.json     # 팀 리더 정보 (예시)
scripts/
  sync-from-source.sh         # 원본 레포 → 템플릿 동기화 스크립트
templates/                    # 산출물 템플릿
CLAUDE.md                     # 프로젝트 규칙
CUSTOMIZATION.md              # 자사 정보 커스터마이징 가이드
```

> 이 레포는 **Next.js 앱이 아닙니다** — Claude Code skill 아키텍처 기반이라 서버/빌드 없이 동작합니다.

---

## MCP 연결 (Step 0에서 세팅)

| 서비스 | 용도 |
|--------|------|
| **Notion** | 온보딩 콘텐츠 fetch, 산출물 저장, 칸반 업데이트 |
| **Slack** | 완료 알림, 팀 연결, 인사 메시지, 피드백 수집 |
| **Gmail** | 이메일 세팅 확인 |
| **Google Calendar** | 일정 확인 |

---

## 라이선스

[MIT License](./LICENSE) — 자유롭게 fork하여 자사에 맞게 수정하세요.

## Credits

제작: [Vivi Lee](https://github.com/Vivi-lee-01) — 블로그: [vivi-blog-three.vercel.app](https://vivi-blog-three.vercel.app)
