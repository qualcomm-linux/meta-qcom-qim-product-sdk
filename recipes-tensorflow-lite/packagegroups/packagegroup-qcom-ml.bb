SUMMARY = "QCOM Machine Learning package groups"
LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

inherit packagegroup

PROVIDES = "${PACKAGES}"

PACKAGES = " \
    ${PN} \
    ${PN}-tflite \
    "

RDEPENDS:${PN}:qcom-custom-bsp = " \
    ${PN}-tflite \
    libgomp-dev \
    qcom-qnn-sdk \
    qcom-snpe-sdk \
    "

RDEPENDS:${PN}-tflite:qcom-custom-bsp = " \
    tensorflow-lite \
    "
