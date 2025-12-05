inherit systemd

# Add the core names to the OVERRIDES
OVERRIDES .= ":${LAYERSERIES_CORENAMES}"

FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/${BPN}:"

DEPENDS:remove:qcom = " libsoup-2.4"

DEPENDS:append:qcom = " libsoup"

SRC_URI:append:qcom = " file://gstd.service \
                                   file://gstd-env_qcm6490 \
                                   file://0001-Delete-pipeline-even-if-state-update-to-NULL-returns.patch \
                                   file://0002-Add-support-for-libsoup-3.0.patch"

EXTRA_OEMESON:qcom = "-Dwith-gstd-logstatedir=/tmp/gstd/ -Dwith-gstd-runstatedir=/tmp/gstd/"

do_configure:prepend:qcom () {
        echo -n "" > ${WORKDIR}/git/libgstc/python/Makefile.am
}

do_install:prepend:qcom () {
       install -d ${D}${exec_prefix}${localstatedir}/run/gstd
       install -d ${D}${exec_prefix}${localstatedir}/log/gstd
}

do_install:append:qcom () {
        install -d ${D}${sysconfdir}/default

        [ ! -f "${WORKDIR}/gstd-env_qcm6490" ] && cp ${WORKDIR}/sources-unpack/gstd-env_qcm6490 ${WORKDIR}/gstd-env_qcm6490
        install -m 666 ${WORKDIR}/gstd-env_qcm6490 ${D}${sysconfdir}/default/gstd

        if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
          echo "d /run/${BPN} - - - -" > ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
          echo "d /${localstatedir}/log/${BPN} 0755 system video -" >> ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
        fi

        install -d ${D}${systemd_system_unitdir}
        [ ! -f "${WORKDIR}/gstd.service" ] && cp ${WORKDIR}/sources-unpack/gstd.service ${WORKDIR}/gstd.service
        install -m 644 ${WORKDIR}/gstd.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN}:qcom = "gstd.service"

FILES:${PN}:append:qcom  = " /tmp/gstd"

INSANE_SKIP:${PN}:append:qcom = " useless-rpaths empty-dirs"
