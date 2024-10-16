FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

FILESPATH =. "${FILE_DIRNAME}/files/:"

SRC_URI:append:coral-dev = "\
    file://imx8mq_phanbell_fix_sdcard_clock.patch \
    file://boot-tools.cfg \
    file://ethernet.cfg \
"
