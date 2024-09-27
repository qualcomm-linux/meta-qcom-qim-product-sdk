inherit cmake pkgconfig

SUMMARY = "Generic ref sample apps for GStreamer pipelines."
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}${LICENSE};md5=3771d4920bd6cdb8cbdf1e8344489ee0"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "gstreamer1.0-plugins-base"
DEPENDS += "gstreamer1.0-plugins-bad"
DEPENDS += "json-glib"
DEPENDS += "libsoup-2.4"
DEPENDS += "qcom-gst-sample-apps-utils"
DEPENDS:append:qcm6490 = " qcom-camera-server"

SRC_URI += "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https;rev=9738171ffc03effaa22e2c4508833544b8879404;branch=imsdk.lnx.2.0.0.r2-rel;subpath=gst-sample-apps/gst-ai-multistream-batch-inference"
S = "${WORKDIR}/gst-ai-multistream-batch-inference"

# Install directries.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

# Camera-related variables
ENABLE_CAMERA          := "FALSE"
CAMERA_SERVICE         := "QMMF"

# Camera-related variables
ENABLE_CAMERA:qcm6490  := "TRUE"
CAMERA_SERVICE:qcm6490 := "LECAM"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"
EXTRA_OECMAKE += "-DENABLE_CAMERA=${ENABLE_CAMERA}"
EXTRA_OECMAKE += "-DCAMERA_SERVICE=${CAMERA_SERVICE}"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
