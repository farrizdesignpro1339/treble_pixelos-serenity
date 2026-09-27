#!/usr/bin/env bash
set -euo pipefail
# sync PixelOS A17 + local_manifests ala restlessos/scripts/sync-sources.sh
# tapi manifest-url diganti PixelOS, bukan GrapheneOS
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
TOP_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="${TOP_DIR}/src"
CONFIGS_DIR="${TOP_DIR}/configs"

mkdir -p "$SRC_DIR"
cd "$SRC_DIR"

echo "y" | repo init --depth=1 --git-lfs \
  -u https://github.com/PixelOS-AOSP/android_manifest -b seventeen

mkdir -p .repo/local_manifests
cp -v "${CONFIGS_DIR}"/manifests/*.xml .repo/local_manifests/

JOBS=$(nproc --all)
echo "repo sync -j${JOBS} ..."
while ! repo sync -c -j${JOBS} --force-sync --no-clone-bundle --no-tags; do
  echo "repo sync failed, retry 30s..."
  sleep 30
done

echo "sync complete. next: ../patches/apply.sh"
