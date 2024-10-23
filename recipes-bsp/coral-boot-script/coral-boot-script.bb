SUMMARY = "U-boot boot scripts for Coral Dev Board"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "u-boot-mkimage-native"

INHIBIT_DEFAULT_DEPS = "1"

SRC_URI = " \
    file://boot_a.txt \
    file://boot_b.txt \
"

do_compile() {
    mkimage -A arm -T script -C none -n "Boot script" -d "${WORKDIR}/boot_a.txt" boot_a.scr
    mkimage -A arm -T script -C none -n "Boot script" -d "${WORKDIR}/boot_b.txt" boot_b.scr
}

inherit deploy nopackages

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot_a.scr ${DEPLOYDIR}
    install -m 0644 boot_b.scr ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build

COMPATIBLE_MACHINE = "coral-dev"
