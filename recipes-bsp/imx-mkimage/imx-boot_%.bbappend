FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#DEPENDS:append:coral-dev = " ${@oe.utils.conditional('UBOOT_ENV', '', 'coral-boot-script', '', d)} "
DEPENDS:append:coral-dev = " coral-boot-script "

BOOT_TOOLS = "imx-boot-tools"

UBOOT_INITIAL_ENV = ""

do_deploy:append() {
    install -m 0777 ${S}/iMX8M/flash.bin  ${DEPLOYDIR}/flash.bin-${MACHINE}-${type}
    install -m 0777 ${S}/iMX8M/flash.bin  ${DEPLOYDIR}/flash.bin-${MACHINE}
    install -m 0777 ${S}/iMX8M/flash.bin  ${DEPLOYDIR}/flash.bin
}
