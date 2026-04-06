# Phase 2: 업무 도구 세팅

## EXPLAIN

### 팀스페이스에서 사용하는 업무 도구

> Notion의 Step 1 General Onboarding 페이지(`step1_general` ID)를 fetch하여
> 최신 체크리스트 항목을 반영하세요.

팀스페이스에서 매일 사용하는 핵심 도구 3가지를 세팅합니다 (Flex, 헤이그라운드는 입사 전 사전 안내에서 이미 완료했어요!):

| 도구 | 용도 | 첫날 할 일 |
|------|------|-----------|
| **Slack** | 업무 소통의 중심 | 앱 설치 + 프로필 설정 + 채널 가입 |
| **Google Workspace** | 메일, 캘린더, 드라이브 | 이메일 서명 설정 + 캘린더 확인 |
| **1Password** | 비밀번호 및 계정 관리 | 팀 공용 계정 로그인 + 브라우저 확장 설치 |

### Slack 채널

- **공개 채널**: Slack에 초대되면 채널봇이 자동으로 공개 채널에 초대해줍니다
- **업무 유관 채널 / 프라이빗 채널**: 팀 동료들이 직접 초대해줄 예정이니 기다려주세요

### Slack 필수 앱 설치

Slack에서 아래 4개 앱을 설치하면 업무가 훨씬 편해집니다.

| 앱 | 용도 | 설치 방법 |
|----|------|-----------|
| **Google Calendar** | 캘린더 일정에 따라 Slack 상태 자동 변경 (회의 중, 부재중 등) + 일정 알림 | Slack 좌측 하단 > **앱** > "Google Calendar" 검색 > **추가** > "Connect an account" 클릭 > `@teamspace.io` 계정으로 로그인 |
| **HRbot** | HR 관련 질문 챗봇 (근태, 휴가, 복리후생, 사내 규정 등) | Slack 좌측 하단 > **앱** > "HRbot" 검색 > **추가** — 설치 후 DM으로 질문하면 됩니다 |
| **회의실예약봇** | 헤이그라운드 회의실 예약/조회 | Slack 좌측 하단 > **앱** > "회의실예약봇" 검색 > **추가** — DM으로 예약 가능 |
| **Flex** | 휴가 승인 알림, 근태 리마인더 등 Flex 알림 수신 | Slack 좌측 하단 > **앱** > "Flex" 검색 > **추가** > Flex 계정 연동 |

> **Google Calendar 앱을 꼭 연동해주세요!** Flex에서 휴가를 등록하면 Google Calendar에 부재중(OOO) 이벤트가 자동 생성되는데, Slack Google Calendar 앱이 연동되어 있어야 Slack 상태도 자동으로 "부재중"으로 바뀝니다.

### 1Password

회사/팀에서 공동 사용하는 각종 계정 정보(서비스 계정, 업무 툴 등)를 안전하게 저장·공유·관리하는 도구입니다.

> 상세 가이드: [1password 이용 가이드 (Notion)](https://www.notion.so/teamspace/1password-1a1c7a52db4f8047809ecd0583bc9ec6)

**로그인 방식**: 개인 계정이 아닌 **팀별 공용 계정**으로 로그인합니다.
- 팀별 공용 계정(dev/biz/prod/mkt/admin)이 있으며, 로그인에 **이메일(공용 계정) + 마스터 패스워드 + 시크릿 키** 3가지가 필요합니다
- 로그인 정보는 소속 팀의 C레벨(리더)에게 문의하세요

**1) 1Password 웹사이트 접속 & 로그인**
- [1password.com/ko](https://1password.com/ko) 에서 공용 계정으로 로그인
- 또는 데스크톱/모바일 앱 설치 후 동일 정보로 로그인

**2) 브라우저 확장 프로그램 설치**
- Chrome 등 브라우저에 [1Password 확장 프로그램](https://chromewebstore.google.com/detail/1password-%E2%80%93-%EB%B9%84%EB%B0%80%EB%B2%88%ED%98%B8-%EA%B4%80%EB%A6%AC-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8/aeblfdkhhhdcdjpifhhbdiojplfjncoa?hl=ko) 설치
- **중요**: 설치 후 반드시 **자동 저장 기능 비활성화** → 개인 정보가 저장되지 않도록!
  - 확장프로그램 설정 → 일반 → "기본 비밀번호 관리 프로그램 설정" / "확장프로그램 통합" **비활성화**

**3) 이용 규칙**
- **업무 관련 계정만** Employee vault에 저장 (개인 계정 저장 금지)
- 비밀번호 변경 시 1Password에도 **즉시 업데이트**
- 공용 계정 정보(이메일/PW/시크릿 키)는 **팀 내에서만 공유**, 외부 노출 금지

> **에이전트 지시**: 1Password는 팀 공용 계정 방식이라 로그인 정보를 소속 팀 리더에게 받아야 한다. "소속 팀 리더(C레벨)에게 1Password 로그인 정보를 문의하세요"라고 안내한다. 아직 정보를 못 받았어도 다음 단계로 넘어갈 수 있다.

### Google Workspace

4가지 설정이 필요합니다:

**1) 이메일 서명 설정**
- 서명 템플릿 문서: https://docs.google.com/document/d/1CyGEl0mntGVwjDMu96dYnv8hEd4mffKKYqoMcFTsEl8/edit
- 설정 경로: Gmail → 설정(⚙️) → 모든 설정 보기 → 일반 → 서명

> **에이전트 지시**: progress.json의 닉네임, 직무, 이메일을 활용하여 "서명 템플릿에서 이름/직무/이메일만 본인 것으로 바꿔서 넣으면 돼요"라고 안내한다.

**2) 캘린더 구독**
- 설정 경로: Google Calendar → 다른 캘린더(+) → 다른 사용자의 캘린더 구독
- **[팀스페이스] 연차 및 근태관리 캘린더** (`c_q0re62dfnhb8a7scqkpbm59jl0@group.calendar.google.com`): 전체 팀원의 휴가·근태를 볼 수 있는 캘린더 (Flex 연동) — 꼭 구독하세요!
- **팀 캘린더**: 소속 팀별 캘린더는 셀 리드나 동료가 안내해줄 거예요 (별도 확인 불필요)

**3) 공유 드라이브 접근 확인**
- Google Drive → 공유 드라이브에서 회사 드라이브가 보이는지 확인
- 접근이 안 되면 HR(Dana)에게 문의

### Flex / 헤이그라운드 — 사전 완료

Flex(근태/급여), 헤이그라운드(공유오피스) 세팅은 **입사 전 사전 안내(D-1)**에서 이미 완료했습니다.
궁금한 점이 있으면 Slack에서 **HRbot**에게 DM으로 물어보세요!
- 예: "연차 신청 어떻게 해?" / "병가 서류 뭐 필요해?" / "헤이그라운드 회의실 어떻게 예약해?"

---

## EXECUTE

> 이번 Phase에서는 🌐 **브라우저**(Slack, Gmail)에서 진행합니다. 모든 세팅이 끝나면 Claude Code로 돌아와주세요.

### 1. 🌐 [Slack으로 이동] Slack 설정
- [ ] **필수 앱 설치** (위 표 참고 — Slack 좌측 하단 > 앱 > 검색 > 추가):
  - [ ] Google Calendar
  - [ ] HRbot
  - [ ] 회의실예약봇
  - [ ] Flex
- [ ] Slack 프로필 사진 등록
- [ ] 프로필에 닉네임 + 직무 입력

> 공개 채널은 채널봇이 자동 초대해줬을 거예요. 업무 유관 채널이나 프라이빗 채널은 팀 동료들이 초대해줄 예정이니 기다려주세요!

### 2. 🌐 [1Password 웹사이트 접속] 1Password 설정
- [ ] 소속 팀 리더(C레벨)에게 1Password 로그인 정보(이메일, 마스터 패스워드, 시크릿 키) 문의
- [ ] [1password.com/ko](https://1password.com/ko) 에서 팀 공용 계정으로 로그인
- [ ] 브라우저 확장 프로그램 설치 + **자동 저장 기능 비활성화**

> 상세 가이드: [1password 이용 가이드 (Notion)](https://www.notion.so/teamspace/1password-1a1c7a52db4f8047809ecd0583bc9ec6)

### 3. 🌐 [Gmail/Calendar/Drive로 이동] Google Workspace 설정
- [ ] Gmail 이메일 서명 설정 ([서명 템플릿](https://docs.google.com/document/d/1CyGEl0mntGVwjDMu96dYnv8hEd4mffKKYqoMcFTsEl8/edit)에서 복사 → Gmail 설정(⚙️) → 모든 설정 보기 → 일반 → 서명에 붙여넣기)
- [ ] Google Calendar에서 **연차 및 근태관리 캘린더** 구독 (필수! 전체 팀원의 휴가 확인용)
  - Google Calendar → 다른 캘린더(+) → 다른 사용자의 캘린더 구독 → `c_q0re62dfnhb8a7scqkpbm59jl0@group.calendar.google.com` 입력
- [ ] 팀 캘린더는 셀 리드/동료가 안내해줄 예정 — 별도 확인 불필요
- [ ] Google Drive 공유 드라이브 접근 확인

> **Tip**: 세팅 중 막히는 부분이 있으면 Claude에게 물어보세요!
> HR 관련 질문은 Slack에서 Dana에게 DM으로 물어봐도 됩니다.
> 🖥️ [Claude Code로 복귀] 세팅이 끝나면 "완료" 또는 "다음"이라고 입력해주세요!

---

## CHECK

- 질문: "도구 세팅이 어디까지 완료됐나요? 아래 중 완료된 항목을 알려주세요:
  1. Slack 프로필 + 채널 가입
  2. Slack 앱 설치 (Google Calendar, HRbot, 회의실예약봇, Flex)
  3. 1Password 팀 공용 계정 로그인 + 브라우저 확장 설치
  4. Google Workspace (이메일 서명, 캘린더, 드라이브)"
- 전부 완료: 축하 + Phase 3 안내
- 일부 미완료: 괜찮다고 격려 + 나중에 마저 할 수 있다고 안내 + Phase 3로 이동 가능
