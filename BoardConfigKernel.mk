KERNEL_PATH := device/lava/LXX516-kernel

# Prebuilt kernel
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# DTB in boot image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb

# Kernel modules — do NOT embed in vendor_boot ramdisk
# TWRP vendor_boot boots with only AVB keys in ramdisk, modules loaded from vendor_dlkm
BOARD_VENDOR_RAMDISK_KERNEL_MODULES :=
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD :=

# vendor_dlkm modules (loaded from stock vendor_dlkm partition)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/modules.load 2>/dev/null))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/*.ko)
