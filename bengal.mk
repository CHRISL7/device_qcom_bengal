# Enable AVB 2.0
BOARD_AVB_ENABLE := true

# Temporary bring-up config -->
ALLOW_MISSING_DEPENDENCIES := true

# For QSSI builds, we should skip building the system image. Instead we build the
# "non-system" images (that we support).

PRODUCT_BUILD_SYSTEM_IMAGE := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true

TARGET_SKIP_OTA_PACKAGE := true
TARGET_SKIP_OTATOOLS_PACKAGE := true

BUILD_BROKEN_PHONY_TARGETS := true
BUILD_BROKEN_DUP_RULES := true
TEMPORARY_DISABLE_PATH_RESTRICTIONS := true
export TEMPORARY_DISABLE_PATH_RESTRICTIONS

# Enable chain partition for system, to facilitate system-only OTA in Treble.
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 0
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_HAVE_BLUETOOTH := false
BOARD_HAVE_QCOM_FM := false
TARGET_DISABLE_PERF_OPTIMIATIONS := false

TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

$(call inherit-product, device/qcom/qssi/common64.mk)
# Temporary bring-up config <--

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Temporary bring-up config -->
PRODUCT_SUPPORTS_VERITY := false
# Temporary bring-up config <--
###########
PRODUCT_PROPERTY_OVERRIDES  += \
     dalvik.vm.heapstartsize=8m \
     dalvik.vm.heapsize=512m \
     dalvik.vm.heaptargetutilization=0.75 \
     dalvik.vm.heapminfree=512k \
     dalvik.vm.heapmaxfree=8m
# Target naming
PRODUCT_NAME := bengal
PRODUCT_DEVICE := bengal
PRODUCT_BRAND := qti
PRODUCT_MODEL := Bengal for arm64


TARGET_USES_AOSP := true
TARGET_USES_AOSP_FOR_AUDIO := false
TARGET_USES_QCOM_BSP := false

# RRO configuration
TARGET_USES_RRO := true

###########
#QMAA flags starts
###########
#QMAA global flag for modular architecture
#true means QMAA is enabled for system
#false means QMAA is disabled for system

TARGET_USES_QMAA := true

#QMAA tech team flag to override global QMAA per tech team
#true means overriding global QMAA for this tech area
#false means using global, no override

#TARGET_USES_QMAA_OVERRIDE_DISPLAY := true
#TARGET_USES_QMAA_OVERRIDE_AUDIO   := true
#TARGET_USES_QMAA_OVERRIDE_VIDEO   := true
#TARGET_USES_QMAA_OVERRIDE_CAMERA  := true
#TARGET_USES_QMAA_OVERRIDE_GFX     := true
#TARGET_USES_QMAA_OVERRIDE_WFD     := true
#TARGET_USES_QMAA_OVERRIDE_SENSORS := true
#TARGET_USES_QMAA_OVERRIDE_PERF    := true

TARGET_USES_QMAA_OVERRIDE_DISPLAY := false
TARGET_USES_QMAA_OVERRIDE_VIDEO   := false
TARGET_USES_QMAA_OVERRIDE_CAMERA  := false
TARGET_USES_QMAA_OVERRIDE_GFX     := false
TARGET_USES_QMAA_OVERRIDE_WFD     := false
TARGET_USES_QMAA_OVERRIDE_SENSORS := false
TARGET_USES_QMAA_OVERRIDE_PERF    := false

TARGET_DISABLE_DISPLAY := true

###########
#QMAA flags ends
###########

###########
# Kernel configurations
TARGET_KERNEL_VERSION := 4.19
#Enable llvm support for kernel
KERNEL_LLVM_SUPPORT := true
#Enable sd-llvm support for kernel
KERNEL_SD_LLVM_SUPPORT := true

###########
# Target configurations

QCOM_BOARD_PLATFORMS += bengal

TARGET_USES_QSSI := true

TARGET_USES_QMAA := true
###QMAA Indicator Start###

#Full QMAA HAL List
QMAA_HAL_LIST :=

#Indicator for each enabled QMAA HAL for this target. Each tech team locally verified their QMAA HAL and ensure code is updated/merged, then add their HAL module name to QMAA_ENABLED_HAL_MODULES as an QMAA enabling completion indicator
QMAA_ENABLED_HAL_MODULES :=

###QMAA Indicator End###

#Default vendor image configuration
ENABLE_VENDOR_IMAGE := true

# Default A/B configuration
ENABLE_AB ?= true

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

# Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += fs_config_files
PRODUCT_PACKAGES += gpio-keys.kl
PRODUCT_PACKAGES += libvolumelistener

ifeq ($(ENABLE_AB), true)
# A/B related packages
PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    bootctrl.bengal \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload
# Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl
endif
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/bengal/framework_manifest.xml

DEVICE_MANIFEST_FILE := device/qcom/bengal/manifest.xml
DEVICE_MATRIX_FILE   := device/qcom/common/compatibility_matrix.xml

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# Powerhint configuration file
PRODUCT_COPY_FILES += device/qcom/bengal/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service \

#
# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
    ro.opengles.version=196610

# Audio configuration file
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/bengal/bengal.mk

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#Enable full treble flag
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
BOARD_SYSTEMSDK_VERSIONS := 28
BOARD_VNDK_VERSION := current
TARGET_MOUNT_POINTS_SYMLINKS := false

PRODUCT_BOOT_JARS += telephony-ext
PRODUCT_PACKAGES += telephony-ext

PRODUCT_BOOT_JARS += tcmiface

# Vendor property to enable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=true

PRODUCT_PROPERTY_OVERRIDES += \
ro.crypto.volume.filenames_mode = "aes-256-cts" \
ro.crypto.allow_encrypt_override = true

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
include device/qcom/wlan/bengal/wlan.mk

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/system/*.mk)
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/vendor/*.mk)
###################################################################################
