inherit systemd

# Prevent systemd service from being installed
do_install:append:qcom-custom-bsp () {
    # Remove the systemd service file
    if [ -f "${D}${systemd_system_unitdir}/redis.service" ]; then
        rm -f ${D}${systemd_system_unitdir}/redis.service
    fi

    # Remove empty systemd directories
    rmdir --ignore-fail-on-non-empty ${D}${systemd_system_unitdir} || true
    rmdir --ignore-fail-on-non-empty ${D}/usr/lib/systemd || true
    rmdir --ignore-fail-on-non-empty ${D}/usr/lib || true
}

# Prevent the package from automatically enabling the service
SYSTEMD_SERVICE:${PN} = ""
SYSTEMD_AUTO_ENABLE = "disable"
