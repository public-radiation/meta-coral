FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG_CONFARGS = ""

SRC_URI += " \
     file://swupdate.cfg \
     file://09-swupdate-args \
     file://swupdate-sysrestart.service \
     file://defconfig \   
     file://boot-boot.mount \
     file://resize-filesystem.service \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
    
    install -m 755 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/swupdate-sysrestart.service  ${D}${systemd_system_unitdir}/
    
    install -d 0755 ${D}/boot/boot
    install -d 0755 ${D}${systemd_system_unitdir}/sysinit.target.wants/
    install -m 0644 ${WORKDIR}/boot-boot.mount   ${D}${systemd_system_unitdir}/
    ln -sf ../boot-boot.mount                    ${D}${systemd_system_unitdir}/sysinit.target.wants/boot-boot.mount

    install -m 0644 ${WORKDIR}/resize-filesystem.service    ${D}${systemd_system_unitdir}/
}

# We don't want to run this service
SYSTEMD_AUTO_ENABLE_${PN}-progress = "disable"
SYSTEMD_SERVICE:${PN} += " swupdate-sysrestart.service "

FILES:${PN} += "/boot/boot ${systemd_system_unitdir}/boot-boot.mount ${systemd_system_unitdir}/sysinit.target.wants/boot-boot.mount"
SYSTEMD_SERVICE:${PN} += " boot-boot.mount "

SYSTEMD_SERVICE:${PN} += " resize-filesystem.service "
