DEVICE_PATH := device/lava/LXX516

# Installs gsi keys into ramdisk, to boot a GSI with verified boot
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Dalvik VM config
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# A/B
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service \
    bootctrl.ums9621 \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Rootdir / Init
PRODUCT_PACKAGES += \
    fstab.ums9621_1h10 \
    init.ums9621_1h10.rc \
    init.ums9621_1h10.usb.rc \
    ueventd.ums9621_1h10.rc

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.ums9621_1h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9621_1h10 \
    $(DEVICE_PATH)/rootdir/etc/fstab.ums9621_1h10:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ums9621_1h10

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-service.unisoc

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-service_64

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.mapper@4.0-impl-arm

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey \
    android.hardware.drm-service.widevine

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.trusty

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

# KeyMint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint@2.0-unisoc.service.trusty

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.1-unisoc-service \
    android.hardware.media.omx@1.0-service

# Neural Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@aidl-service-armnn-gpu

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.unisoc

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi.hostapd-service \
    android.hardware.wifi.supplicant-service \
    hostapd \
    libwifi-hal-unisoc \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/unisoc

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 35

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 33

# Device properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=Spreadtrum \
    ro.soc.model=UMS9621S

# Screen
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.6 \
    dalvik.vm.heapminfree=8m \
    dalvik.vm.heapmaxfree=16m
