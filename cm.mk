# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/sony/hikari/device.mk)

TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1280

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hikari
PRODUCT_NAME := cm_hikari
PRODUCT_BRAND := Sony
PRODUCT_MODEL := Xperia Acro S
PRODUCT_MANUFACTURER := Sony
