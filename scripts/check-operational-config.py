#!/usr/bin/env python3
"""온보딩 운영 설정 사전 점검.

Notion/Slack 업데이트는 실패해도 온보딩 본문을 막지 않지만,
운영 설정이 비어 있으면 카드/DM이 조용히 누락된다. 이 스크립트는
런타임 시작 전에 누락/placeholder를 명확히 드러내기 위한 가드다.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
CONFIG_DIR = ROOT / "config"
PLACEHOLDER_RE = re.compile(r"^(YOUR_|UXXXXXXXXXX|\{\{|U0EXAMPLE)")


def load_json(path: Path) -> tuple[dict[str, Any] | None, str | None]:
    if not path.exists():
        return None, f"missing: {path.relative_to(ROOT)}"
    try:
        return json.loads(path.read_text(encoding="utf-8")), None
    except json.JSONDecodeError as exc:
        return None, f"invalid json: {path.relative_to(ROOT)}:{exc.lineno}:{exc.colno} {exc.msg}"


def is_placeholder(value: Any) -> bool:
    return isinstance(value, str) and bool(PLACEHOLDER_RE.search(value.strip()))


def check_required_string(errors: list[str], data: dict[str, Any], path: str) -> None:
    cur: Any = data
    for part in path.split("."):
        if not isinstance(cur, dict) or part not in cur:
            errors.append(f"missing key: {path}")
            return
        cur = cur[part]
    if not isinstance(cur, str) or not cur.strip():
        errors.append(f"empty string: {path}")
        return
    if is_placeholder(cur):
        errors.append(f"placeholder value: {path}")


def main() -> int:
    parser = argparse.ArgumentParser(description="온보딩 운영 설정 사전 점검")
    parser.add_argument("--json", action="store_true", help="JSON으로 결과 출력")
    args = parser.parse_args()

    errors: list[str] = []
    warnings: list[str] = []

    notion, err = load_json(CONFIG_DIR / "notion-ids.json")
    if err:
        errors.append(err)
    else:
        assert notion is not None
        for key in ["onboarding_db", "step1_general", "step2_product", "step3_biz", "step6_live_audit"]:
            check_required_string(errors, notion, key)

    team, err = load_json(CONFIG_DIR / "team-leads.json")
    if err:
        errors.append(err)
    else:
        assert team is not None
        # HR 진행 알림 수신자와 Step 2/3 도메인 오너는 런타임 DM에 필수다.
        check_required_string(errors, team, "hr_lead.slack_id")
        check_required_string(errors, team, "hr_lead.nickname")
        check_required_string(errors, team, "step_domain_owners.step2_product.slack_id")
        check_required_string(errors, team, "step_domain_owners.step3_biz.slack_id")
        check_required_string(errors, team, "step_domain_owners.step3_biz.contact")

        # 자주 쓰는 팀/셀 매핑은 누락 시 팀장 알림이 빠질 수 있으므로 warning으로 둔다.
        for key in ["team_leads", "cell_to_team"]:
            if key not in team:
                warnings.append(f"missing optional map: {key}")

    ok = not errors
    result = {"ok": ok, "errors": errors, "warnings": warnings}
    if args.json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        if ok:
            print("OK: 온보딩 운영 설정 사용 가능")
            for warning in warnings:
                print(f"WARN: {warning}")
        else:
            print("BLOCKED: 온보딩 운영 설정을 먼저 채워야 합니다")
            for error in errors:
                print(f"ERROR: {error}")
            for warning in warnings:
                print(f"WARN: {warning}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
