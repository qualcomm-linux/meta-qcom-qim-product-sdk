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

SRCPROJECT = "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https"
SRCBRANCH  = "imsdk.lnx.2.0.0.r2-rel"
SRCREV     = "043ee4e6f6b43989fd100614b1fdc99e616edc1c"

SRC_URI = "${SRCPROJECT};branch=${SRCBRANCH};rev=${SRCREV};subpath=gst-plugin-qmmfsrc"
S = "${WORKDIR}/gst-plugin-qmmfsrc"

# Install directries.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

# Default platform definitions.
IMAGE_MAX_WIDTH                      := "4096"
IMAGE_MAX_HEIGHT                     := "4096"
VIDEO_MAX_WIDTH                      := "4096"
VIDEO_MAX_HEIGHT                     := "4096"
VIDEO_MAX_FPS                        := "120/1"
CAMERA_METADATA_VERSION              := "1.0"
VIDEO_TYPE_SUPPORT                   := "TRUE"
MULTI_CAMERA_ENABLE                  := "FALSE"
EIS_MODES_ENABLE                     := "TRUE"
VHDR_MODES_ENABLE                    := "TRUE"
VIDEO_UYVY_FORMAT_ENABLE             := "FALSE"
VIDEO_YUY2_FORMAT_ENABLE             := "FALSE"
VIDEO_P010_10LE_FORMAT_ENABLE        := "FALSE"
VIDEO_NV12_10LE32_FORMAT_ENABLE      := "FALSE"
IMAGE_NV12_FORMAT_ENABLE             := "FALSE"
FEATURE_LOGICAL_CAMERA_SUPPORT       := "FALSE"
FEATURE_LOGICAL_CAMERA_SENSOR_SWITCH := "FALSE"
FEATURE_OFFLINE_IFE_SUPPORT          := "TRUE"

# Overwrite the default platform definitions for qcm6490
IMAGE_MAX_WIDTH:qcm6490    := "5184"
IMAGE_MAX_HEIGHT:qcm6490   := "3880"
VIDEO_MAX_WIDTH:qcm6490    := "5184"
VIDEO_MAX_HEIGHT:qcm6490   := "3880"

# Overwrite the default platform definitions for qcs9100
IMAGE_MAX_WIDTH:qcs9100    := "5184"
IMAGE_MAX_HEIGHT:qcs9100   := "3880"
VIDEO_MAX_WIDTH:qcs9100    := "5184"
VIDEO_MAX_HEIGHT:qcs9100   := "3880"

# Overwrite the default platform definitions for qcs8300
IMAGE_MAX_WIDTH:qcs8300    := "5184"
IMAGE_MAX_HEIGHT:qcs8300   := "3880"
VIDEO_MAX_WIDTH:qcs8300    := "5184"
VIDEO_MAX_HEIGHT:qcs8300   := "3880"


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
EXTRA_OECMAKE += "-DCAMERA_METADATA_VERSION=${CAMERA_METADATA_VERSION}"
EXTRA_OECMAKE += "-DGST_VIDEO_YUY2_FORMAT_ENABLE=${VIDEO_YUY2_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_UYVY_FORMAT_ENABLE=${VIDEO_UYVY_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_P010_10LE_FORMAT_ENABLE=${VIDEO_P010_10LE_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_NV12_10LE32_FORMAT_ENABLE=${VIDEO_NV12_10LE32_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_IMAGE_NV12_FORMAT_ENABLE=${IMAGE_NV12_FORMAT_ENABLE}"
EXTRA_OECMAKE += "-DGST_VIDEO_TYPE_SUPPORT=${VIDEO_TYPE_SUPPORT}"
EXTRA_OECMAKE += "-DEIS_MODES_ENABLE=${EIS_MODES_ENABLE}"
EXTRA_OECMAKE += "-DVHDR_MODES_ENABLE=${VHDR_MODES_ENABLE}"
EXTRA_OECMAKE += "-DFEATURE_OFFLINE_IFE_SUPPORT=${FEATURE_OFFLINE_IFE_SUPPORT}"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
