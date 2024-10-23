FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

FILESPATH =. "${FILE_DIRNAME}/files/:"

SRC_URI:append:coral-dev = "\
    file://imx8mq_phanbell_fix_sdcard_clock.patch \
    file://phanbell_boot_filesystem_agnostic.patch \
    file://imx8mq_phanbell_enable_usb3_support.patch \
    file://boot-tools.cfg \
    file://ethernet.cfg \
    file://usb-fastboot-support.cfg \
"
