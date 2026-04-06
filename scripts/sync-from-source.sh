#!/bin/bash
# sync-from-source.sh — 원본 온보딩 레포에서 템플릿 레포로 동기화
# 사용법: ./scripts/sync-from-source.sh [--dry-run]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# .env.local 로드
if [[ ! -f "$SCRIPT_DIR/.env.local" ]]; then
  echo "❌ scripts/.env.local이 없습니다."
  echo "   cp scripts/.env.example scripts/.env.local 후 SOURCE_REPO 경로를 설정하세요."
  exit 1
fi
source "$SCRIPT_DIR/.env.local"

if [[ ! -d "$SOURCE_REPO" ]]; then
  echo "❌ SOURCE_REPO 경로가 존재하지 않습니다: $SOURCE_REPO"
  exit 1
fi

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 Dry-run 모드 — 실제 변경 없이 미리보기만 합니다."
  echo ""
fi

# ─────────────────────────────────────────────
# 1단계: rsync로 파일 복사
# ─────────────────────────────────────────────
echo "📦 1단계: 원본에서 파일 복사..."

RSYNC_OPTS=(
  -av --delete
  # 제외: 참여자 데이터/임시 파일
  --exclude='outputs/'
  --exclude='_workspace/'
  --exclude='.playwright-mcp/'
  --exclude='.git/'
  --exclude='.DS_Store'
  # 제외: 로컬 설정/상태
  --exclude='.claude/settings.local.json'
  --exclude='config/repo-watch-state.json'
  --exclude='config/notion-ids.json'
  --exclude='config/team-leads.json'
  --exclude='TODO.md'
  # 보존: 템플릿 고유 파일 (덮어쓰지 않음)
  --exclude='README.md'
  --exclude='CUSTOMIZATION.md'
  --exclude='LICENSE'
  --exclude='scripts/'
  # 보존: 템플릿 고유 config
  --exclude='config/notion-ids.example.json'
  --exclude='config/team-leads.example.json'
)

if $DRY_RUN; then
  RSYNC_OPTS+=(--dry-run)
fi

rsync "${RSYNC_OPTS[@]}" "$SOURCE_REPO/" "$TEMPLATE_DIR/" 2>&1 | grep -v '^\.' | head -50

# ─────────────────────────────────────────────
# 2단계: 문자열 치환
# ─────────────────────────────────────────────
echo ""
echo "🔄 2단계: 문자열 치환 적용..."

# 치환 맵 — 긴 문자열부터 (순서 중요!)
# 형식: "원본|치환"
REPLACEMENTS=(
  # --- 회사/서비스 (긴 것부터) ---
  "futureschole-ai-all|teamspace-ai-all"
  "notion.so/futureschole|notion.so/teamspace"
  "futureschole|teamspace"
  "liveklasscorp|teamspacecorp"
  "backoffice.liveklass.com|admin.collabo.io"
  "@liveklass.com|@teamspace.io"
  "liveklass|collabo"
  "퓨쳐스콜레|팀스페이스"
  "라이브클래스|콜라보"
  "라클러|스페이서"
  "Lakler|Spacer"

  # --- Slack ID (인물보다 먼저) ---
  "U088ALTS1L2|U0EXAMPLE01"
  "U083JFBBHTK|U0EXAMPLE02"
  "URJA3JQSF|U0EXAMPLE03"

  # --- 인물 (긴 이름부터) ---
  "이보배|이다나"
  "vivi.lee|dana.lee"
  "vivi\.lee|dana.lee"

  # --- 조직명 ---
  "로켓런칭셀|Onboarding셀"
  "로켓런칭팀|Onboarding팀"
  "로켓런칭|Onboarding셀"
  "세일즈셀|Sales셀"
  "경영관리실장|Operations실장"
  "경영관리팀|Operations팀"
  "경영관리실|Operations실"
  "경영관리|Operations"
  "사업팀|Growth팀"
  "플랫폼셀|Platform셀"
  "HR셀|People셀"

  # --- 제품/도메인 고유 (긴 복합 표현부터!) ---
  "S/VIP 라이브 청강|Enterprise 온보딩 세션 참관"
  "SVIP 라이브 청강|Enterprise 온보딩 세션 참관"
  "라이브 청강|Enterprise 온보딩 세션 참관"
  "크리에이터|워크스페이스 오너"
  "수강생|멤버"
  "S/VIP|Enterprise"
  "SVIP|Enterprise"
  "크리투스|Acme Corp"
  "터닝포인트 스쿨|TechFlow"
  "돈버는클래스|DataPrime"
  "페이션트퍼널|ScaleUp"
  "#19-live-monitoring|#cs-enterprise-support"
  "#00-liveklass-announcements|#00-teamspace-announcements"

  # --- 인물 (짧은 이름, 맨 마지막) ---
  # 주의: 단독 단어로만 치환하면 위험 (예: "Rich"가 "enriched" 안에 포함)
  # sed 워드 바운더리로 처리
)

# 단독 인물명 치환 (워드 바운더리 필요)
# 형식: "원본|치환" — sed에서 \b 대신 패턴 사용
PERSON_REPLACEMENTS=(
  "Vivi|Dana"
  "David|James"
  "Song|Alex"
  "Eddie|Morgan"
  "Ethan|Chris"
  "Kobe|Kai"
  "Rich|Jake"
  "Ian|Noah"
  "Ryan|Kai"
  "Rogi|Sam"
  "June|Leo"
  "정준영|김민준"
  "Johnny|Jamie"
  "Bryan|Brian"
  "Didi|Mina"
)

if $DRY_RUN; then
  echo "  (dry-run: 치환 미적용)"
  echo ""
  echo "적용될 치환 규칙: ${#REPLACEMENTS[@]} + ${#PERSON_REPLACEMENTS[@]}건"
else
  # 치환 대상 파일 (텍스트 파일만)
  TARGET_FILES=$(find "$TEMPLATE_DIR" \
    -type f \( -name "*.md" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" \) \
    -not -path "*/scripts/*" \
    -not -path "*/.git/*" \
    -not -path "*/README.md" \
    -not -path "*/CUSTOMIZATION.md" \
    -not -path "*/LICENSE")

  # 일반 치환 (부분 문자열 매칭)
  for rule in "${REPLACEMENTS[@]}"; do
    from="${rule%%|*}"
    to="${rule##*|}"
    for f in $TARGET_FILES; do
      if grep -q "$from" "$f" 2>/dev/null; then
        sed -i '' "s|$from|$to|g" "$f"
      fi
    done
  done

  # 인물명 치환 (한글은 그대로, 영문은 워드 바운더리 근사)
  for rule in "${PERSON_REPLACEMENTS[@]}"; do
    from="${rule%%|*}"
    to="${rule##*|}"
    for f in $TARGET_FILES; do
      if grep -q "$from" "$f" 2>/dev/null; then
        # 한글 이름: 그대로 치환
        if [[ "$from" =~ [가-힣] ]]; then
          sed -i '' "s|$from|$to|g" "$f"
        else
          # 영문 이름: 앞뒤가 영문자가 아닌 경우만 치환
          # (예: "Rich"는 치환하되 "enriched"는 건드리지 않음)
          sed -i '' "s|\\([^a-zA-Z]\\)${from}\\([^a-zA-Z]\\)|\\1${to}\\2|g" "$f"
          # 줄 시작/끝 케이스
          sed -i '' "s|^${from}\\([^a-zA-Z]\\)|${to}\\1|g" "$f"
          sed -i '' "s|\\([^a-zA-Z]\\)${from}\$|\\1${to}|g" "$f"
        fi
      fi
    done
  done

  echo "  ✅ 치환 완료"
fi

# ─────────────────────────────────────────────
# 3단계: 결과 요약
# ─────────────────────────────────────────────
echo ""
echo "📊 3단계: 변경 요약"
echo "─────────────────────────────────────────"
cd "$TEMPLATE_DIR"
if git diff --stat --quiet 2>/dev/null; then
  echo "  변경 없음"
else
  git diff --stat
  echo ""
  echo "─────────────────────────────────────────"
  echo "다음 단계:"
  echo "  1. git diff 파일명     → 변경 내용 확인"
  echo "  2. git restore 파일명  → 필요 시 원복"
  echo "  3. git add -A && git commit -m '원본 동기화'"
fi
