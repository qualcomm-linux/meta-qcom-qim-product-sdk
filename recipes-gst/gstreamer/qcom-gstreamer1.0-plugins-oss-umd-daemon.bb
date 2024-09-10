inherit cmake pkgconfig

SUMMARY = "GStreamer based daemon utilizing Qualcomm UMD gadget library"
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "qcom-gstreamer1.0-plugins-oss-mlmeta"
DEPENDS += "qti-umd-gadget"
DEPENDS += "${@bb.utils.contains("QCOM_AFR_ALGO", "TRUE", "qti-auto-framing-stabilization", "", d)}"

RDEPENDS:${PN} := "qti-umd-gadget"
RDEPENDS:${PN} += "${@bb.utils.contains("QCOM_AFR_ALGO", "TRUE", "qti-auto-framing-stabilization", "", d)}"

SRC_URI += "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https;rev=c7328821abdcb59ab2216357946cc3931b3638e3;branch=imsdk.lnx.2.0.0.r2-rel;subpath=gst-umd-daemon"
S = "${WORKDIR}/gst-umd-daemon"

# Install directries.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"
FILES:${PN} += "/data/"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
