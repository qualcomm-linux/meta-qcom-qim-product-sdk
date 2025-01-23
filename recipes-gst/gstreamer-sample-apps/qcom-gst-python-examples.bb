inherit pkgconfig

SUMMARY = "Generic ref python example apps for GStreamer pipelines."
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}${LICENSE};md5=3771d4920bd6cdb8cbdf1e8344489ee0"

# Dependencies.
RDEPENDS:${PN} := "gstreamer1.0-python"

SRCPROJECT = "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https"
SRCBRANCH  = "imsdk.lnx.2.0.0.r2-rel"
SRCREV     = "ed15004492fa3927dd867d3e377ba5cf4411b71f"

SRC_URI = "${SRCPROJECT};branch=${SRCBRANCH};rev=${SRCREV};rev=${SRCREV};subpath=gst-python-examples"
S = "${WORKDIR}/gst-python-examples"

do_install() {
    mkdir -p ${D}${bindir}
    install -m 755 ${S}/*.py ${D}${bindir}/
}
