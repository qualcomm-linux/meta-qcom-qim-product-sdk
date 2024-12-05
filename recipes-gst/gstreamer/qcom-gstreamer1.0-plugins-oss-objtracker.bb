inherit cmake pkgconfig

SUMMARY = "Qualcomm open-source GStreamer Plug-in for tracking meta objects throughout consecutive frames"
SECTION = "multimedia"

LICENSE = "MIT & BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause-Clear;md5=7a434440b651f4a472ca93716d01033a \
                    file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "gstreamer1.0-plugins-base"
DEPENDS += "qcom-gstreamer1.0-plugins-oss-base"
DEPENDS += "libeigen"

SRC_URI = "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https;rev=c8a7eb64a9fd96de0d205ce7604211f3768f83c5;branch=imsdk.lnx.2.0.0.r2-rel;subpath=gst-plugin-objtracker/"
S = "${WORKDIR}/gst-plugin-objtracker"

# Install directories.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DKERNEL_BUILDDIR=${STAGING_KERNEL_BUILDDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"

EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_LICENSE=BSD"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_VERSION=${PV}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_PACKAGE=${PN}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_SUMMARY="${SUMMARY}""
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_ORIGIN="Unknown package origin""

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

FILES:${PN}-dbg += "${INSTALL_LIBDIR}/gstreamer-1.0/.debug"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""