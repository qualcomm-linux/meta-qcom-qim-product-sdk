inherit systemd

# Add the core names to the OVERRIDES
OVERRIDES .= ":${LAYERSERIES_CORENAMES}"

DEPENDS:append:qcom-custom-bsp = " libsoup-2.4"

FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/${BPN}:"

LIC_FILES_CHKSUM:qcom-custom-bsp = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI:append:qcom-custom-bsp = " file://gstd.service \
                                   file://0001-Unblock-GSTD-pipeline-if-a-plugin-refuses-to-change-.patch \
                                   file://0001-gstd-Change-symlinks-to-relative-in-gstd-and-gst-cli.patch"

SRCREV:qcom-custom-bsp = "d924fcbc2123dcfcb35242ecf5dc2fc3049004b3"

SRC_URI:append:qcom-custom-bsp = " file://gstd-env_qcm6490"

SRC_URI:remove:qcom-custom-bsp = "file://0001-gstd-yocto-compatibility.patch"

SRC_URI:append:qcom-custom-bsp = " file://0002-gstd-update-python-pip-command.patch"

EXTRA_OEMESON:qcom-custom-bsp = "-Dwith-gstd-logstatedir=/var/log/gstd/"

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

        install -d -m 777 ${D}${exec_prefix}${localstatedir}/run/gstd
        install -d -m 777 ${D}${exec_prefix}${localstatedir}/log/gstd
}

SYSTEMD_SERVICE:${PN}:qcom-custom-bsp = "gstd.service"

FILES:${PN}:append:qcom-custom-bsp  = " ${exec_prefix}${localstatedir}/run/gstd ${exec_prefix}${localstatedir}/log/gstd"

INSANE_SKIP:${PN}:append:qcom-custom-bsp = " useless-rpaths empty-dirs"
