#!/usr/bin/env bash
# extract-files.sh for LAVA LXX516 (Unisoc UMS9621)
# Usage: ./extract-files.sh [src_dir]

set -e

DEVICE="LXX516"
VENDOR="lava"
DEVICE_PATH="device/${VENDOR}/${DEVICE}"
VENDOR_PATH="vendor/${VENDOR}/${DEVICE}"

# Source: either a mounted partition dir or ADB
SRC="$1"
if [ -z "$SRC" ]; then
    SRC="adb"
fi

function adb_pull() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ "$SRC" = "adb" ]; then
        adb pull "$src" "$dst" 2>/dev/null || true
    else
        cp -a "${SRC}${src}" "$dst" 2>/dev/null || true
    fi
}

echo "Extracting blobs for $DEVICE from $SRC..."

# --- Audio ---
adb_pull /vendor/lib64/hw/audio.primary.ums9621.so          $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/audio.bluetooth.ums9621.so        $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/audio.dp.ums9621.so               $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/etc/audio_policy_configuration.xml         $VENDOR_PATH/proprietary/vendor/etc/
adb_pull /vendor/etc/audio_policy_volumes.xml               $VENDOR_PATH/proprietary/vendor/etc/ 2>/dev/null || true
adb_pull /vendor/lib/hw/audio.primary.ums9621.so            $VENDOR_PATH/proprietary/vendor/lib/hw/ 2>/dev/null || true

# --- Camera ---
adb_pull /vendor/lib64/hw/camera.unisoc.so                  $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/android.hardware.camera.provider@2.4-impl-sprd.so $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib/hw/camera.unisoc.so                    $VENDOR_PATH/proprietary/vendor/lib/hw/ 2>/dev/null || true

# --- Display / GPU ---
adb_pull /vendor/lib64/hw/hwcomposer.unisoc.so              $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/dpu.unisoc.so                     $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/gsp.unisoc.so                     $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/enhance.unisoc.so                 $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/vulkan.ums9621.so                 $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/android.hardware.graphics.allocator@4.0-impl-arm.so $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/android.hardware.graphics.mapper@4.0-impl-arm.so   $VENDOR_PATH/proprietary/vendor/lib64/hw/

# --- WiFi ---
adb_pull /vendor/lib64/hw/libwifi-hal-unisoc.so             $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/liblowi_wifihal.so                $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/etc/wifi/wpa_supplicant.conf               $VENDOR_PATH/proprietary/vendor/etc/wifi/ 2>/dev/null || true

# --- Bluetooth ---
adb_pull /vendor/lib64/hw/vendor.sprd.hardware.connmgr@1.0-impl.so $VENDOR_PATH/proprietary/vendor/lib64/hw/

# --- Boot Control ---
adb_pull /vendor/lib64/hw/bootctrl.default.so               $VENDOR_PATH/proprietary/vendor/lib64/hw/
adb_pull /vendor/lib64/hw/unisoc.bootctrl.so                $VENDOR_PATH/proprietary/vendor/lib64/hw/

# --- Thermal ---
adb_pull /vendor/lib64/hw/vendor.sprd.hardware.thermal@2.0-impl.so $VENDOR_PATH/proprietary/vendor/lib64/hw/

# --- Trusty ---
adb_pull /vendor/lib64/hw/vendor.sprd.hardware.trusty-impl.so $VENDOR_PATH/proprietary/vendor/lib64/hw/

# --- Sensors ---
adb_pull /vendor/lib64/hw/sensors.unisoc.so                 $VENDOR_PATH/proprietary/vendor/lib64/hw/ 2>/dev/null || true

# --- Firmware ---
adb_pull /vendor/firmware/                                   $VENDOR_PATH/proprietary/vendor/firmware/

# --- Vendor bins ---
adb_pull /vendor/bin/                                        $VENDOR_PATH/proprietary/vendor/bin/

# --- Vendor libs ---
adb_pull /vendor/lib64/                                      $VENDOR_PATH/proprietary/vendor/lib64/
adb_pull /vendor/lib/                                        $VENDOR_PATH/proprietary/vendor/lib/ 2>/dev/null || true

echo "Extraction complete!"
echo "Run setup-makefiles.sh to generate Android.bp / Android.mk"
