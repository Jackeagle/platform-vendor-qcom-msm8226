TARGET_USES_QCOM_BSP := true
TARGET_USES_QCA_NFC := false

ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8226/overlay

#TARGET_DISABLE_DASH := true
#TARGET_DISABLE_OMX_SECURE_TEST_APP := true

# media_profiles and media_codecs xmls for 8226
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8226/media/media_profiles_8226.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8226/media/media_codecs_8226.xml:system/etc/media_codecs.xml
endif

$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8226
PRODUCT_DEVICE := msm8226

-include $(QCPATH)/common/config/rendering-engine.mk

# font rendering engine feature switch
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLOAD))))
    MULTI_LANG_ENGINE := REVERIE
endif

PRODUCT_BOOT_JARS += qcmediaplayer:WfdCommon:oem-services:qcom.fmradio:org.codeaurora.Performance:vcard

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/msm8226/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/msm8226/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/qcom/msm8226/audio_platform_info.xml:system/etc/audio_platform_info.xml

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# Bluetooth configuration files
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

#spec service
PRODUCT_PACKAGES += init.qti.carrier.rc

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8226/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += wcnss_service \
		    pronto_wlan.ko

#ANT stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

# NFC packages
ifeq ($(TARGET_USES_QCA_NFC),true)
NFC_D := true

ifeq ($(NFC_D), true)
    PRODUCT_PACKAGES += \
        libnfcD-nci \
        libnfcD_nci_jni \
        nfc_nci.msm8226 \
        NfcDNci \
        Tag \
        com.android.nfc_extras \
        com.android.nfc.helper
else
    PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8226 \
    NfcNci \
    Tag \
    com.android.nfc_extras
endif

# IMS SDK packages
PRODUCT_PACKAGES += \
    imsapi.xml \
    imsapi \
    imssdkservice \
    libsdkimscamera_jni \
    libsdkvt_jni

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml
endif # TARGET_USES_QCA_NFC

PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
        frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_COPY_FILES += \
    device/qcom/msm8226/whitelist_appops.xml:system/etc/whitelist_appops.xml

#Set default profile to FUT
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.logkit.ctrlcode=1

PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK in_ID

PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
    $(QCPATH)/qrdplus/Extension/res-overlay \
    $(PRODUCT_PACKAGE_OVERLAYS)
