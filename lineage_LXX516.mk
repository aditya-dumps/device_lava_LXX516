# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device
$(call inherit-product, device/lava/LXX516/device.mk)

# Inherit crDroid specific configs
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := LXX516
PRODUCT_NAME := lineage_LXX516
PRODUCT_BRAND := LAVA
PRODUCT_MODEL := LAVA LXX516
PRODUCT_MANUFACTURER := LAVA

PRODUCT_GMS_CLIENTID_BASE := android-lava

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="LXX516-user 15 AP3A.240905.015.A2 60 release-keys"

BUILD_FINGERPRINT := LAVA/LXX516/LXX516:15/AP3A.240905.015.A2/60:user/release-keys
