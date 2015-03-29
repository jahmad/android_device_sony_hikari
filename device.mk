#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, vendor/sony/hikari/device-vendor.mk)

$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# overlay
DEVICE_PACKAGE_OVERLAYS += device/sony/hikari/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# kernel
PRODUCT_PACKAGES += \
    kernel

# Light
PRODUCT_PACKAGES += \
    lights.msm8660

# Display
PRODUCT_PACKAGES += \
    liboverlay \
    hwcomposer.msm8660 \
    gralloc.msm8660 \
    memtrack.msm8660 \
    copybit.msm8660

# Media
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libOmxVdec \
    libOmxVenc \
    libOmxCore \
    libstagefrighthw \
    libc2dcolorconvert

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8660 \
    audio.a2dp.default \
    audio.usb.default \
	audio.r_submix.default \
	libaudio-resampler

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \
    $(LOCAL_PATH)/rootdir/system/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/rootdir/system/etc/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/rootdir/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/rootdir/system/etc/mixer_paths.xml:system/etc/mixer_paths.xml

# NFC
PRODUCT_PACKAGES += \
    nfc.msm8660 \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/nfcee_access.xml:system/etc/nfcee_access.xml

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor \
    libbluedroid \
    brcm_patchram_plus

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface \
    libwpa_client \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/wifi/calibration:system/etc/wifi/calibration

WIFI_BAND := 802_11_BG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)

# DASH
PRODUCT_PACKAGES += \
    sensors.msm8660

PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/rootdir/system/etc/sensors.conf:system/etc/sensors.conf

# GPS
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/rootdir/system/etc/gps.conf:system/etc/gps.conf

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# Configuration scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/flashled_calc_parameters.cfg:system/etc/flashled_calc_parameters.cfg \
    $(LOCAL_PATH)/rootdir/system/etc/iddd.conf:system/etc/iddd.conf \
    $(LOCAL_PATH)/rootdir/system/etc/qosmgr_rules.xml:system/etc/qosmgr_rules.xml \
    $(LOCAL_PATH)/rootdir/system/etc/thermald-semc.conf:system/etc/thermald-semc.conf

# Common Qualcomm / Sony scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init.netconfig.sh:system/etc/init.netconfig.sh \
    $(LOCAL_PATH)/rootdir/system/etc/pre_hw_config.sh:system/etc/pre_hw_config.sh \
    $(LOCAL_PATH)/rootdir/system/etc/hw_config.sh:system/etc/hw_config.sh \
    $(LOCAL_PATH)/rootdir/system/etc/clearpad_fwloader.sh:system/etc/clearpad_fwloader.sh

# Custom init / uevent
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.semc:root/fstab.semc \
    $(LOCAL_PATH)/rootdir/init.semc.rc:root/init.semc.rc \
    $(LOCAL_PATH)/rootdir/init.semc.service.rc:root/init.semc.service.rc \
    $(LOCAL_PATH)/rootdir/init.semc.usb.rc:root/init.semc.usb.rc \
    $(LOCAL_PATH)/rootdir/ueventd.semc.rc:root/ueventd.semc.rc

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.recovery.semc.rc:root/init.recovery.semc.rc \
    $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_PACKAGES += \
    extract_elf_ramdisk

# USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Key layouts and touchscreen
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/usr/idc/clearpad.idc:system/usr/idc/clearpad.idc \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/clearpad.kl:system/usr/keylayout/clearpad.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/fuji-keypad.kl:system/usr/keylayout/fuji-keypad.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/gpio-key.kl:system/usr/keylayout/gpio-key.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/keypad-pmic-fuji.kl:system/usr/keylayout/keypad-pmic-fuji.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/pmic8058_pwrkey.kl:system/usr/keylayout/pmic8058_pwrkey.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/simple_remote.kl:system/usr/keylayout/simple_remote.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/simple_remote_appkey.kl:system/usr/keylayout/simple_remote_appkey.kl

PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=1

PRODUCT_TAGS += dalvik.gc.type-precise
