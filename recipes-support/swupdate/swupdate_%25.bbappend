FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG_CONFARGS = ""

SRC_URI += " \
     file://swupdate.cfg \
     file://09-swupdate-args \
     file://swupdate-sysrestart.service \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
    
    install -m 755 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/

    install -d ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/swupdate-sysrestart.service ${D}${systemd_system_unitdir}
}

# We don't want to run this service
SYSTEMD_AUTO_ENABLE_${PN}-progress = "disable"
SYSTEMD_SERVICE:${PN} += " swupdate-sysrestart.service"