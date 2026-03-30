require recipes-qcom-ml/qcom-ml.inc

SUMMARY = "ONNX Runtime"
HOMEPAGE = "https://github.com/microsoft/onnxruntime"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0f7e3b1308cb5c00b372a6e78835732d"

S = "${WORKDIR}/git"
OECMAKE_SOURCEPATH = "${S}/cmake"

inherit python3native python3-dir cmake

SRC_URI = "gitsm://github.com/microsoft/onnxruntime.git;protocol=https;branch=rel-${PV};name=ort"
SRCREV_ort = "${AUTOREV}"

DEPENDS += " \
    cmake-native \
    protobuf \
    protobuf-native \
    zlib \
    qcom-qnn-sdk \
    onnx \
"

QNN_SDK_ROOT = "${STAGING_DATADIR}/qnn-sdk"

CXXFLAGS:append = " -Wno-maybe-uninitialized"

EXTRA_OECMAKE=" \
    -DCMAKE_BUILD_TYPE=Release \
    -DONNX_CUSTOM_PROTOC_EXECUTABLE=${STAGING_BINDIR_NATIVE}/protoc \
    -DCMAKE_FIND_ROOT_PATH=${STAGING_DIR_TARGET} \
    -DCMAKE_SYSTEM_PROCESSOR=arm64 \
    -Dprotobuf_WITH_ZLIB=OFF \
    -Donnxruntime_BUILD_SHARED_LIB=ON \
    -Donnxruntime_DEV_MODE=OFF \
    -DFETCHCONTENT_FULLY_DISCONNECTED=OFF \
    -Donnxruntime_BUILD_UNIT_TESTS=OFF \
    -Donnxruntime_RUN_ONNX_TESTS=OFF \
    -Donnxruntime_QNN_HOME=${QNN_SDK_ROOT} \
    -Donnxruntime_USE_QNN=ON \
    -Donnxruntime_DISABLE_RTTI=OFF \
"

do_configure[network] = "1"
do_compile[network] = "1"

do_install:append() {
    ${STRIP} --strip-debug ${D}${libdir}/libonnxruntime.so.${PV}
}

FILES:${PN} = " \
    ${libdir}/libonnxruntime.so.* \
    ${libdir}/libonnxruntime_providers_*.so \
"

FILES:${PN}-dev = " \
    ${includedir}/* \
    ${libdir}/cmake/* \
    ${libdir}/pkgconfig/* \
    ${libdir}/libonnxruntime.so \
"
