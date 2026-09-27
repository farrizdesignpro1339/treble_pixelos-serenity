# patches/personal/platform_device_phh_treble/
# taruh patch rw-system.sh serenity lu di sini, contoh penamaan:
# 0001-serenity-ril-audio-lights.patch
# 0002-serenity-fingerprint-overlay.patch
#
# format folder -> repo mapping (dari apply.sh):
# device_phh_treble -> device/phh/treble
# platform_system_sepolicy -> system/sepolicy
# platform_frameworks_base -> frameworks/base
# platform_vendor_hardware_overlay -> vendor/hardware_overlay
#
# bikin patch dengan:
#   cd src/device/phh/treble
#   git diff > ../../../../patches/personal/device_phh_treble/0001-xxx.patch
