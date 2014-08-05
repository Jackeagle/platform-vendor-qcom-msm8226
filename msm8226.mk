TARGET_USES_QCOM_BSP := false
TARGET_USES_QCA_NFC := true

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8226/overlay

#TARGET_DISABLE_DASH := true
#TARGET_DISABLE_OMX_SECURE_TEST_APP := true

# media_profiles and media_codecs xmls for 8226
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8226/media/media_profiles_8226.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8226/media/media_codecs_8226.xml:system/etc/media_codecs.xml
endif

$(call inherit-product, device/qcom/common/common.mk)

$(call inherit-product, device/google/clockwork/build/clockwork_google.mk)
# include clockwork-services, if present (for full-source PDK builds)
$(call inherit-product-if-exists,vendor/google_clockwork/products/clockwork_services.mk)

PRODUCT_NAME := msm8226
PRODUCT_DEVICE := msm8226
PRODUCT_BRAND := ANDROID

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/synaptics_rmi4_i2c.kcm:system/usr/keychars/synaptics_rmi4_i2c.kcm \
    device/qcom/msm8226/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc \
    device/qcom/msm8226/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/msm8226/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/msm8226/mixer_paths.xml:system/etc/mixer_paths.xml
    device/device/qcom/msm8226/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl

# System tools
PRODUCT_PACKAGES += \
    applypatch \
    e2fsck \
    libdl \
    libgabi++ \
    local_time.default \
    make_ext4fs \
    power.default \
    run-as \
    setup_fs

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom
#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8226/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin \
    device/qcom/msm8226/WCNSS_qcom_wlan_nv.bin:$(TARGET_OUT)/system/vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_COPY_FILES += \
    device/qcom/msm8226/whitelist_appops.xml:system/etc/whitelist_appops.xml

PRODUCT_PACKAGES += ClockworkExampleWatchFace

PRODUCT_PROPERTY_OVERRIDES += \
        ro.opengles.version=131072 \
        ro.sf.lcd_density=240 \
        bluetooth.force_pm_timer=1000 \

# screen density config, for framework
PRODUCT_AAPT_CONFIG := small hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_CHARACTERISTICS := nosdcard,watch

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/wearable_core_hardware.xml:system/etc/permissions/wearable_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml

# Display
PRODUCT_PACKAGES += \
    memtrack.msm8226

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/persist/bdaddr.txt

#$(call inherit-product, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product-if-exists, hardware/qcom/msm8x26/msm8x26.mk)

# The msm8x26 uses the msm8x74 GPU libraries
$(call inherit-product-if-exists, vendor/qcom/gpu/msm8x26/msm8x26-gpu-vendor.mk)

$(call inherit-product, device/google/clockwork/build/wearable-mdpi-512-dalvik-heap.mk)
