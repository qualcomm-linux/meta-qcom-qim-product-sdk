inherit pkgconfig

SUMMARY = "Generic ref python example apps for GStreamer pipelines."
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}${LICENSE};md5=3771d4920bd6cdb8cbdf1e8344489ee0"

# Dependencies.
RDEPENDS:${PN} := "gstreamer1.0-python bash"

SRCPROJECT = "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https"
SRCBRANCH  = "imsdk.lnx.2.0.0.r2-rel"
SRCREV     = "4d3e15b3ce316a18c49e9383a11ccdb16cd1238e"

SRC_URI = "${SRCPROJECT};branch=${SRCBRANCH};subpath=gst-python-examples"
S = "${WORKDIR}/gst-python-examples"

INSTALL_CONFIG := "${sysconfdir}/media/"

do_install() {
    mkdir -p ${D}${bindir}
    mkdir -p ${D}${INSTALL_CONFIG}
    install -m 755 ${S}/*.py ${D}${bindir}/
    install -m 755 ${S}/files/Qdemo ${D}${bindir}/
    install -m 755 ${S}/files/Qdemo.png ${D}${INSTALL_CONFIG}
    install -m 755 ${S}/files/Qdemo.gif ${D}${INSTALL_CONFIG}
}
