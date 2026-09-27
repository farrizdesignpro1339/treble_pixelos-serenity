# treble_pixelos-serenity (Android 17)

Repo sendiri ala `cawilliamson/treble_restlessos` branch `android-17.0`, tapi base **PixelOS-AOSP seventeen** + patches ramping buat serenity/gale.

Struktur ngikutin restlessos:
```
patches/apply.sh              # strict: git am, gagal = abort (jangan || true)
patches/trebledroid/          # TrebleDroid upstream A17
patches/rom/                  # adaptasi PixelOS -> GSI
patches/personal/             # custom serenity lu
patches/release-builds/       # khusus user build
configs/manifests/            # default.xml + remove.xml -> .repo/local_manifests
configs/rom/rom.mk            # product definition
scripts/                      # sync / reset / test
upstream/                     # vendored sources buat test patch tanpa sync full
```

## Cara pakai di PC rom-builder

```bash
# 1. sync PixelOS A17
mkdir -p src && cd src
repo init -u https://github.com/PixelOS-AOSP/manifest -b seventeen --git-lfs --depth=1
mkdir -p .repo/local_manifests
cp ../configs/manifests/*.xml .repo/local_manifests/
repo sync -c -j12 --force-sync --no-clone-bundle --no-tags

# 2. apply patches (urutan sama kayak build pipeline)
cd src
../patches/apply.sh . trebledroid
../patches/apply.sh . rom
../patches/apply.sh . personal
../patches/apply.sh . release-builds

# 3. test doang tanpa build
../scripts/test-patches.sh --reset

# 4. lunch format baru A17 (bukan bgN lagi)
source build/envsetup.sh
list_products | grep -i custom
lunch custom_arm64 trunk_staging userdebug
mka -j12 systemimage
```

Kredit struktur: cawilliamson/treble_restlessos, phhusson, TrebleDroid, PixelOS.
