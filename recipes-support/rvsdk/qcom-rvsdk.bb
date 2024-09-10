DESCRIPTION      = "Qualcomm Robotics Vision SDK"
LICENSE          = "Qualcomm-Technologies-Inc.-Proprietary"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}/${LICENSE};md5=58d50a3d36f27f1a1e6089308a49b403"

RVSDK_SRC_VER="r1.0_00039.2"

SRC_URI = "https://artifacts.codelinaro.org/artifactory/qli-ci/software/chip/qualcomm_linux-spf-1-0/qualcomm-linux-spf-1-0_test_device_public/${RVSDK_SRC_VER}/le-qcrobotics-1-0-r1/apps_proc/prebuilt_HY22/mono-vslam_1.0_armv8-2a.tar.gz"
SRC_URI[sha256sum] = "58f108b42bf3c52aa9a0e8cf1e00ed96526488f1f1c6301beed2f5606a1870c7"

RVSDK_DIR = "${WORKDIR}/opt/qcom/qirf-sdk/usr/"

do_compile[noexec] = "1"
do_package_qa[noexec] = "1"

do_install() {
    install -d ${D}/${includedir}
    install -d ${D}/${libdir}/

    cp -r ${RVSDK_DIR}/lib/* ${D}/${libdir}
    cp -r ${RVSDK_DIR}/include/* ${D}/${includedir}
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

SOLIBS = ".so"
FILES_SOLIBSDEV = ""

FILES:${PN} += "${libdir}/*"
FILES:${PN} += "${includedir}/*"
