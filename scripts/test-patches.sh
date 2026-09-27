#!/usr/bin/env bash
set -euo pipefail
# ala restlessos/scripts/test-patches.sh - apply semua tier, stop keras pas gagal
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
TOP_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="${TOP_DIR}/src"
PATCHES_DIR="${TOP_DIR}/patches"

DEBUG=0
RESET=0
for a in "$@"; do
  [[ "$a" == "--debug" ]] && DEBUG=1
  [[ "$a" == "--reset" ]] && RESET=1
done

[[ -d "$SRC_DIR/.repo" ]] || { echo "ERROR: no .repo di $SRC_DIR, jalanin scripts/sync-sources.sh dulu"; exit 1; }
cd "$SRC_DIR"
[[ "$RESET" -eq 1 ]] && "$SCRIPT_DIR/reset-sources.sh"

TIERS=(trebledroid rom personal)
[[ "$DEBUG" -eq 1 ]] && TIERS+=(debug-builds) || TIERS+=(release-builds)

echo "==> applying: ${TIERS[*]}"
for tier in "${TIERS[@]}"; do
  echo "--- tier: $tier ---"
  "${PATCHES_DIR}/apply.sh" . "$tier"
done
echo "PASS: all tiers applied cleanly."
