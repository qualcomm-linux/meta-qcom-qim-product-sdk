inherit systemd

# Add the core names to the OVERRIDES
OVERRIDES .= ":${LAYERSERIES_CORENAMES}"

FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/${BPN}:"

DEPENDS:remove:qcom-custom-bsp = " libsoup-2.4"

DEPENDS:append:qcom-custom-bsp = " libsoup"

SRC_URI:append:qcom-custom-bsp = " file://gstd.service \
                                   file://gstd-env_qcm6490 \
                                   file://0001-Delete-pipeline-even-if-state-update-to-NULL-returns.patch \
                                   file://0002-Add-support-for-libsoup-3.0.patch \
                                   file://0003-Update-deprecated-meson-functions.patch"

EXTRA_OEMESON:qcom-custom-bsp = "-Dwith-gstd-logstatedir=/tmp/gstd/ -Dwith-gstd-runstatedir=/tmp/gstd/"

do_configure:prepend:qcom-custom-bsp () {
        echo -n "" > ${WORKDIR}/git/libgstc/python/Makefile.am
}

do_install:prepend:qcom-custom-bsp () {
       install -d ${D}${exec_prefix}${localstatedir}/run/gstd
       install -d ${D}${exec_prefix}${localstatedir}/log/gstd
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
}

SYSTEMD_SERVICE:${PN}:qcom-custom-bsp = "gstd.service"

FILES:${PN}:append:qcom-custom-bsp  = " /tmp/gstd"

INSANE_SKIP:${PN}:append:qcom-custom-bsp = " useless-rpaths empty-dirs"
