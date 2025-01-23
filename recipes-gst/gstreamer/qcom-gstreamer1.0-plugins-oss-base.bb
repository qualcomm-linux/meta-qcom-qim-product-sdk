inherit cmake pkgconfig

SUMMARY = "Qualcomm open-source GStreamer base"
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "gstreamer1.0-plugins-base"
DEPENDS += "qcom-adreno"
DEPENDS += "qcom-fastcv-binaries"
DEPENDS:append:qcs9100 = " qcom-displaydlkm"
DEPENDS:append:qcs8300 = " qcom-displaydlkm"

SRCPROJECT = "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https"
SRCBRANCH  = "imsdk.lnx.2.0.0.r2-rel"
SRCREV     = "ed15004492fa3927dd867d3e377ba5cf4411b71f"

SRC_URI = "${SRCPROJECT};branch=${SRCBRANCH};rev=${SRCREV};subpath=gst-plugin-base"
S = "${WORKDIR}/gst-plugin-base"

# Install directries.
INSTALL_INCDIR := "${includedir}"
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DKERNEL_BUILDDIR=${STAGING_INCDIR}/linux-msm"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_INCDIR=${INSTALL_INCDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"

PACKAGECONFIG = "${@bb.utils.contains('PREFERRED_PROVIDER_virtual/libgbm', 'msm', '', 'gbm', d)} "
PACKAGECONFIG[gbm] = " , ,gbm,gbm"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
