# ROM configuration buat PixelOS GSI serenity (A17)
# file ini dicopy ke device/phh/treble/pixelos-serenity.mk pas build
# contoh dari treble_restlessos/configs/rom/rom.mk

# ensure product fonts dir exists
$(shell mkdir -p $(PRODUCT_OUT)/system/product/fonts)

# PixelOS gsans fonts
$(call inherit-product-if-exists, vendor/pixel/gsans/common/common-vendor.mk)

# hemat image: dexpreopt cuma bootclasspath + system_server
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true

# serenity overlay (ganti dengan path overlay lu)
# PRODUCT_PACKAGE_OVERLAYS += vendor/hardware_overlay/Serenity

# GSI tweaks serenity
# TARGET_SYSTEM_PROP += device/phh/treble/system_serenity.prop
