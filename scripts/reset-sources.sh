#!/usr/bin/env bash
set -euo pipefail
# ala restlessos/scripts/reset-sources.sh - reset semua repo yg ada patch ke base
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
TOP_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="${TOP_DIR}/src"
PATCHES_DIR="${TOP_DIR}/patches"

map_project_to_src() {
  local p
  p="$(tr _ / <<<"$1" | sed -e 's;platform/;;g')"
  [[ "$p" == build ]] && p=build/make
  [[ "$p" == treble/app ]] && p=treble_app
  [[ "$p" == vendor/hardware/overlay ]] && p=vendor/hardware_overlay
  echo "$p"
}

projects=$(for tier in trebledroid rom personal release-builds debug-builds; do
  d="${PATCHES_DIR}/${tier}"; [[ -d "$d" ]] && ls "$d"
done | sort -u)

find "$SRC_DIR" -name index.lock -delete 2>/dev/null || true

for project in $projects; do
  path="${SRC_DIR}/$(map_project_to_src "$project")"
  [[ -d "$path/.git" ]] || continue
  (cd "$path" && git am --abort >/dev/null 2>&1 || true
   base="$(git rev-list --max-parents=0 HEAD | tail -1)"
   git reset --hard "$base" >/dev/null
   git clean -fdx >/dev/null
   echo "reset $project -> $base")
done
echo "reset done."
