TARGET_USES_QCOM_BSP := true

ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8226/overlay

# media_profiles and media_codecs xmls for 8226
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8226/media/media_profiles_8226.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8226/media/media_codecs_8226.xml:system/etc/media_codecs.xml
endif

$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8226
PRODUCT_DEVICE := msm8226

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/audio_policy.conf:system/etc/audio_policy.conf \

# Bluetooth configuration files
PRODUCT_COPY_FILES += \
	system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf \
	device/qcom/msm8226/snd_soc_msm/snd_soc_msm_Tapan:system/etc/snd_soc_msm/snd_soc_msm_Tapan \
	device/qcom/msm8226/snd_soc_msm/snd_soc_msm_Tapan_SKUF:system/etc/snd_soc_msm/snd_soc_msm_Tapan_SKUF \
	device/qcom/msm8226/snd_soc_msm/snd_soc_msm_TapanLite:system/etc/snd_soc_msm/snd_soc_msm_TapanLite \

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom \
    init.qcom.spec.switch.rc

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8226/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    device/qcom/msm8226/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8226/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += wcnss_service

#ANT stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

#LogSystem
LogSystem := Logkit
LogSystem += SystemAgent
LogSystem += qlogd
LogSystem += qlog-conf.xml
LogSystem += wifi.cfg
LogSystem += ftrace.cfg
LogSystem += kernelevent.cfg
LogSystem += diag_mdlog
LogSystem += rootagent
LogSystem += init.qcom.rootagent.sh
LogSystem += cdrom_install.iso

PRODUCT_PACKAGES += $(LogSystem)

# NFC packages
PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8226 \
    NfcNci \
    Tag \
    com.android.nfc_extras

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/qcom/msm8226/nfc/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/qcom/msm8226/nfc/nfcee_access_debug.xml
endif

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
        device/qcom/msm8226/nfc/libnfc-nci.conf:system/etc/libnfc-nci.conf


#LogSystem
LogSystem := Logkit
LogSystem += SystemAgent
LogSystem += qlogd
LogSystem += qlog-conf.xml
LogSystem += wifi.cfg
LogSystem += kernelevent.cfg
LogSystem += diag_mdlog
LogSystem += rootagent
LogSystem += cdrom_install.iso

PRODUCT_PACKAGES += $(LogSystem)

PRODUCT_LOCALES += xhdpi
# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_COPY_FILES += \
    device/qcom/msm8226/whitelist_appops.xml:system/etc/whitelist_appops.xml
