DESCRIPTION      = "Qualcomm Robotics Vision SDK"
LICENSE          = "Qualcomm-Technologies-Inc.-Proprietary"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}/${LICENSE};md5=58d50a3d36f27f1a1e6089308a49b403"

RVSDK_BUILD_ID    = "r1.0_00049.0"

SRC_URI = "https://qartifactory-edge.qualcomm.com/artifactory/qsc_releases/software/chip/qualcomm_linux-spf-1-0/qualcomm-linux-spf-1-0_test_device_pb_qirpsdk/${RVSDK_BUILD_ID}/le-qcrobotics-1-0-r1/apps_proc/prebuilt_HY22/mono-vslam_1.0_aarch64.tar.gz"
SRC_URI[sha256sum] = "aff3912682d2dcad3a1ac5f2dc6bbeb34316ab7b8f9a407af344ffcb29692a22"

RVSDK_DIR = "${WORKDIR}/opt/qcom/qirf-sdk/usr/"

do_compile[noexec] = "1"
do_package_qa[noexec] = "1"

do_install() {
    install -d ${D}/${includedir}
    install -d ${D}/${libdir}/

    cp -r ${RVSDK_DIR}/lib/*.so ${D}/${libdir}
    cp -r ${RVSDK_DIR}/include/* ${D}/${includedir}
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

SOLIBS = ".so"
FILES_SOLIBSDEV = ""

FILES:${PN} = "${libdir}/*.so"
FILES:${PN}-dev += "${includedir}/*"

INSANE_SKIP:${PN} += "installed-vs-shipped"
