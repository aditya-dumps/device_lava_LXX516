KERNEL_PATH := device/lava/LXX516-kernel

# Prebuilt kernel
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# DTB in boot image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb

# Kernel modules — REQUIRED in vendor_boot ramdisk
# Use MINIMAL modules.load — full list includes native_hang_monitor.ko which
# reboots the device after 6s when Android framework isn't up (first-stage init)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/modules.load.vendor_boot 2>/dev/null))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/*.ko)

# vendor_dlkm modules — full set loaded by second-stage init from vendor_dlkm partition
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/modules.load 2>/dev/null))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/*.ko)
