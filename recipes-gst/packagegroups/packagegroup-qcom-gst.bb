SUMMARY = "Qualcomm Gstreamer package groups"
LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

PROVIDES = "${PACKAGES}"
PACKAGE_ARCH = "${SOC_ARCH}"

inherit packagegroup

PACKAGES = " \
    ${PN}-dependencies \
    ${PN} \
    "

RDEPENDS:${PN}-dependencies = " \
    gdk-pixbuf \
    hiredis \
    json-glib \
    liba52 \
    libdaemon \
    libgudev \
    lame \
    libnice \
    libpsl \
    librsvg \
    libsoup-2.4 \
    libsrtp \
    libtheora \
    libwebp \
    mpg123 \
    orc \
    sbc \
    speex \
    srt \
    taglib \
    mosquitto \
    qcom-rvsdk \
    "

RDEPENDS:${PN}:qcom-custom-bsp = " \
    ${PN}-dependencies \
    ${PN}-basic \
    ${PN}-sample-apps \
    gstd \
    gstreamer1.0-python \
    qcom-gstreamer1.0-plugins-oss-base \
    qcom-gstreamer1.0-plugins-oss-tools \
    qcom-gstreamer1.0-plugins-oss-batch \
    qcom-gstreamer1.0-plugins-oss-dfs \
    qcom-gstreamer1.0-plugins-oss-metamux \
    qcom-gstreamer1.0-plugins-oss-metatransform \
    qcom-gstreamer1.0-plugins-oss-mlaconverter \
    qcom-gstreamer1.0-plugins-oss-mlaclassification \
    qcom-gstreamer1.0-plugins-oss-mldemux \
    qcom-gstreamer1.0-plugins-oss-mlmeta \
    qcom-gstreamer1.0-plugins-oss-mlmetaparser \
    qcom-gstreamer1.0-plugins-oss-mlvconverter \
    qcom-gstreamer1.0-plugins-oss-mlvclassification \
    qcom-gstreamer1.0-plugins-oss-mlvsuperresolution \
    qcom-gstreamer1.0-plugins-oss-mlvdetection \
    qcom-gstreamer1.0-plugins-oss-mlvpose \
    qcom-gstreamer1.0-plugins-oss-mlvsegmentation \
    qcom-gstreamer1.0-plugins-oss-msgbroker \
    qcom-gstreamer1.0-plugins-oss-objtracker \
    qcom-gstreamer1.0-plugins-oss-overlay \
    qcom-gstreamer1.0-plugins-oss-qmmfsrc \
    qcom-gstreamer1.0-plugins-oss-redissink \
    qcom-gstreamer1.0-plugins-oss-restricted-zone \
    qcom-gstreamer1.0-plugins-oss-rtspbin \
    qcom-gstreamer1.0-plugins-oss-smartvencbin \
    qcom-gstreamer1.0-plugins-oss-socket \
    qcom-gstreamer1.0-plugins-oss-test-framework \
    qcom-gstreamer1.0-plugins-oss-vcomposer \
    qcom-gstreamer1.0-plugins-oss-voverlay \
    qcom-gstreamer1.0-plugins-oss-vsplit \
    qcom-gstreamer1.0-plugins-oss-vtransform \
   "

