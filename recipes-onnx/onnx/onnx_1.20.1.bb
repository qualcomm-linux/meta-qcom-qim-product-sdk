SUMMARY = "Open Neural Network Exchange (ONNX)"
DESCRIPTION = "ONNX is an open format built to represent machine learning models"
HOMEPAGE = "https://github.com/onnx/onnx.git"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI = "git://github.com/onnx/onnx.git;protocol=https;branch=rel-${PV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

inherit cmake

DEPENDS = " \
    cmake-native \
    protobuf \
    protobuf-native \
"

EXTRA_OECMAKE = " \
    -DCMAKE_BUILD_TYPE=Release \
    -DONNX_USE_PROTOBUF_SHARED_LIBS=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DONNX_USE_LITE_PROTO=OFF \
    -DONNX_GEN_PB_TYPE_STUBS=OFF \
    -DONNX_BUILD_TESTS=OFF \
    -DONNX_BUILD_BENCHMARKS=OFF \
    -DProtobuf_PROTOC_EXECUTABLE=${STAGING_BINDIR_NATIVE}/protoc \
    -DProtobuf_INCLUDE_DIR=${STAGING_INCDIR} \
    -DProtobuf_LIBRARY=${STAGING_LIBDIR}/libprotobuf.so \
"

# Put all shared libraries in runtime package
FILES:${PN} += " \
    ${libdir}/libonnx*.so* \
"

FILES:${PN}-dev = " \
    ${includedir}/* \
    ${libdir}/cmake/* \
    ${libdir}/pkgconfig/* \
"
