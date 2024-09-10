inherit systemd

DEPENDS:append:qcom-custom-bsp = " libsoup-2.4"

FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/${BPN}:"

SRC_URI:append:qcom-custom-bsp = " file://gstd.service \
                                   file://0001-Unblock-GSTD-pipeline-if-a-plugin-refuses-to-change-.patch"

SRCREV:qcom-custom-bsp = "d924fcbc2123dcfcb35242ecf5dc2fc3049004b3"

SRC_URI:append:qcom-custom-bsp = " file://gstd-env_qcm6490"

SRC_URI:remove:qcom-custom-bsp = "file://0001-gstd-yocto-compatibility.patch"

EXTRA_OECONF:qcom-custom-bsp = "--with-gstd-runstatedir=/tmp"

do_configure:prepend:qcom-custom-bsp () {
        echo -n "" > ${WORKDIR}/git/libgstc/python/Makefile.am
}

do_install:prepend:qcom-custom-bsp () {
        install -d ${D}${localstatedir}/run/gstd
        install -d ${D}${localstatedir}/log/gstd
}

do_install:append:qcom-custom-bsp () {
        install -d ${D}${sysconfdir}/default
        install -m 666 ${WORKDIR}/gstd-env_qcm6490 ${D}${sysconfdir}/default/gstd

        if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
          echo "d /run/${BPN} - - - -" > ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
          echo "d /${localstatedir}/log/${BPN} 0755 system video -" >> ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
        fi

        install -d ${D}${systemd_system_unitdir}
        install -m 644 ${WORKDIR}/gstd.service ${D}${systemd_system_unitdir}

        rm -rf ${D}${localstatedir}/run
}

SYSTEMD_SERVICE:${PN}:qcom-custom-bsp = "gstd.service"

FILES:${PN}:append:qcom-custom-bsp = " /tmp"

INSANE_SKIP:${PN}:append:qcom-custom-bsp = " useless-rpaths empty-dirs"
