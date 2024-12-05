inherit cmake pkgconfig

SUMMARY = "Qualcomm open-source GStreamer Plug-in for qmmf-sdk"
HOMEPAGE = "http://www.qualcomm.com"
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "gstreamer1.0-plugins-base"
DEPENDS += "qcom-gstreamer1.0-plugins-oss-base"
DEPENDS += "qcom-camera-server"

SRC_URI += "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https;rev=c8a7eb64a9fd96de0d205ce7604211f3768f83c5;branch=imsdk.lnx.2.0.0.r2-rel;subpath=gst-plugin-qmmfsrc"
S = "${WORKDIR}/gst-plugin-qmmfsrc"

# Install directries.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

# Default platform definitions.
IMAGE_MAX_WIDTH         := "4096"
IMAGE_MAX_HEIGHT        := "4096"
VIDEO_MAX_WIDTH         := "4096"
VIDEO_MAX_HEIGHT        := "4096"
VIDEO_MAX_FPS           := "120/1"
CAMERA_METADATA_VERSION := "1.0"
VIDEO_TYPE_SUPPORT      := "FALSE"
CAMERA_SERVICE          := "QMMF"
EIS_MODES_ENABLE        := "FALSE"
VHDR_MODES_ENABLE       := "FALSE"

# Overwrite the default platform definitions for qcm6490
VIDEO_TYPE_SUPPORT:qcm6490 := "TRUE"
CAMERA_SERVICE:qcm6490     := "LECAM"
IMAGE_MAX_WIDTH:qcm6490    := "5184"
IMAGE_MAX_HEIGHT:qcm6490   := "3880"
VIDEO_MAX_WIDTH:qcm6490    := "5184"
VIDEO_MAX_HEIGHT:qcm6490   := "3880"
EIS_MODES_ENABLE:qcm6490   := "TRUE"
VHDR_MODES_ENABLE:qcm6490  := "TRUE"

# Overwrite the default platform definitions for qcs9100
VIDEO_TYPE_SUPPORT:qcs9100 := "TRUE"
CAMERA_SERVICE:qcs9100     := "LECAM"
IMAGE_MAX_WIDTH:qcs9100    := "5184"
IMAGE_MAX_HEIGHT:qcs9100   := "3880"
VIDEO_MAX_WIDTH:qcs9100    := "5184"
VIDEO_MAX_HEIGHT:qcs9100   := "3880"
EIS_MODES_ENABLE:qcs9100   := "TRUE"
VHDR_MODES_ENABLE:qcs9100  := "TRUE"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"

EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_LICENSE=BSD"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_VERSION=${PV}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_PACKAGE=${PN}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_SUMMARY="${SUMMARY}""
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_ORIGIN=${HOMEPAGE}"

EXTRA_OECMAKE += "-DGST_IMAGE_MAX_WIDTH=${IMAGE_MAX_WIDTH}"
EXTRA_OECMAKE += "-DGST_IMAGE_MAX_HEIGHT=${IMAGE_MAX_HEIGHT}"

EXTRA_OECMAKE += "-DGST_VIDEO_MAX_WIDTH=${VIDEO_MAX_WIDTH}"
EXTRA_OECMAKE += "-DGST_VIDEO_MAX_HEIGHT=${VIDEO_MAX_HEIGHT}"
EXTRA_OECMAKE += "-DGST_VIDEO_MAX_FPS=${VIDEO_MAX_FPS}"
EXTRA_OECMAKE += "-DGST_VIDEO_H265_ENABLE=${VIDEO_H265_ENABLE}"
EXTRA_OECMAKE += "-DCAMERA_METADATA_VERSION=${CAMERA_METADATA_VERSION}"
EXTRA_OECMAKE += "-DGST_VIDEO_YUY2_FORMAT_ENABLE=${VIDEO_YUY2_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_UYVY_FORMAT_ENABLE=${VIDEO_UYVY_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_P010_10LE_FORMAT_ENABLE=${VIDEO_P010_10LE_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_NV12_10LE32_FORMAT_ENABLE=${VIDEO_NV12_10LE32_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_IMAGE_NV12_FORMAT_ENABLE=${IMAGE_NV12_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_TYPE_SUPPORT=${VIDEO_TYPE_SUPPORT}"
EXTRA_OECMAKE += "-DCAMERA_SERVICE=${CAMERA_SERVICE}"
EXTRA_OECMAKE += "-DEIS_MODES_ENABLE=${EIS_MODES_ENABLE}"
EXTRA_OECMAKE += "-DVHDR_MODES_ENABLE=${VHDR_MODES_ENABLE}"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
