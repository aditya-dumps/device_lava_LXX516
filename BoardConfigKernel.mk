KERNEL_PATH := device/lava/LXX516-kernel

# Prebuilt kernel
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# DTB in boot image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb

# Kernel modules (vendor_boot ramdisk)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules.load 2>/dev/null))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/*.ko)

# vendor_dlkm modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules.load.vendor_dlkm 2>/dev/null))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/vendor_dlkm/*.ko)
