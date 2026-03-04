include ../qcom-ml.inc
inherit autotools pkgconfig

LICENSE          = "Qualcomm-Technologies-Inc.-Proprietary"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}/${LICENSE};md5=58d50a3d36f27f1a1e6089308a49b403"

SUMMARY          = "QNN-SDK"
DESCRIPTION      = "Qualcomm Neural Network SDK"

SRC_URI[sha256sum] = "${QNPSDK_SRC_SHID}"

SRC_URI = "https://softwarecenter.qualcomm.com/api/download/software/sdks/Qualcomm_AI_Runtime_Community/All/${QNPSDK_SRC_VER}/v${QNPSDK_SRC_VER}.zip"

QNN_DIR = "${WORKDIR}/qairt/${QNPSDK_SRC_VER}"

def platform_dir(d):
    gccversion  = d.getVar("GCCVERSION", True).strip('%').split('.')[0]
    gccversion_integer = int(gccversion)
    sdk_lib_dir = d.getVar("QNN_DIR", True) + "/lib/"
    dir_prefix = "aarch64-oe-linux-gcc"
    for version in range (gccversion_integer, 8, -1):
        gccversion = str(version)
        pf_dir = dir_prefix + gccversion
        if os.path.exists(sdk_lib_dir) and os.path.isdir(sdk_lib_dir):
            for folder in os.listdir(sdk_lib_dir):
                if folder.startswith(pf_dir):
                    pf_dir += "*"
                    return pf_dir

PLATFORM_DIR = "${@platform_dir(d)}"

do_compile[noexec] = "1"
do_package_qa[noexec] = "1"

do_install() {
    install -d ${D}/${bindir}
    install -d ${D}/${includedir}
    install -d ${D}/${libdir}/rfsa/adsp

    install -m 0755 ${QNN_DIR}/lib/${PLATFORM_DIR}/*Qnn* ${D}/${libdir}
    install -m 0755 ${QNN_DIR}/lib/${PLATFORM_DIR}/libPlatformValidatorShared.so ${D}/${libdir}
    install -m 0755 ${QNN_DIR}/lib/${PLATFORM_DIR}/libcalculator.so ${D}/${libdir}
    install -m 0755 ${QNN_DIR}/bin/${PLATFORM_DIR}/qnn* ${D}/${bindir}
    install -m 0755 ${QNN_DIR}/bin/${PLATFORM_DIR}/qtld-net-run ${D}/${bindir}
    install -m 0755 ${QNN_DIR}/lib/${HEXAGON_DIR}/unsigned/libQnn* ${D}/${libdir}/rfsa/adsp
    install -m 0755 ${QNN_DIR}/lib/${HEXAGON_DIR}/unsigned/libCalculator_skel.so ${D}/${libdir}/rfsa/adsp

    cp -r ${QNN_DIR}/include/QNN/* ${D}/${includedir}
    chmod -R 0755 ${D}/${includedir}

    # Install complete QNN_DIR structure to dev package for dependent recipes
    install -d ${D}${datadir}/qnn-sdk
    cp -r ${QNN_DIR}/* ${D}${datadir}/qnn-sdk/
    chmod -R 0755 ${D}${datadir}/qnn-sdk
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

# Inhibit stripping for dev package to avoid errors with non-aarch64 binaries (Hexagon DSP)
INHIBIT_SYSROOT_STRIP = "1"

INSANE_SKIP_${PN} += "arch"
INSANE_SKIP:${PN}-dev += "arch already-stripped"

def get_qnn_sdk_libs(d):
    import os

    destdir = d.getVar('D')
    datadir = d.getVar('datadir')
    qnn_sdk_dir = destdir + datadir + '/qnn-sdk/lib'

    if not os.path.exists(qnn_sdk_dir):
        return ""

    libs = set()
    for root, dirs, files in os.walk(qnn_sdk_dir):
        for file in files:
            if '.so' in file:
                libs.add(os.path.basename(file))

    return ' '.join(sorted(libs))

# Mark all libraries in qnn-sdk directory as private to avoid shlib provider conflicts
PRIVATE_LIBS:${PN}-dev = "${@get_qnn_sdk_libs(d)}"

SOLIBS = ".so"
FILES_SOLIBSDEV = ""

FILES:${PN} += "${libdir}/*"
FILES:${PN} += "${bindir}/*"
FILES:${PN}-dev += "${includedir}/*"
FILES:${PN}-dev += "${datadir}/qnn-sdk/*"
