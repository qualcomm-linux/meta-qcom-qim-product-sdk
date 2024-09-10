DEPENDS:append:qcom-custom-bsp = " qemu-native"
FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-good/1.20:"

SRC_URI:append:qcom-custom-bsp = "\
     file://0002-v4l2-Add-support-for-fd-memory-import.patch \
     file://0003-gstreamer1.0-plugins-good-modify-caps.patch \
     file://0004-v4l2-Add-support-for-dma-memory-allocation.patch \
     file://0005-v4l2-Add-support-for-dynamic-resolution-change.patch \
     file://0006-v4l2-support-for-controls-and-input-formats.patch \
     file://0007-v4l2-Handle-srccaps-and-GAP-buffer.patch \
     file://0008-gstreamer1.0-plugins-good-Add-meson-option-to-build-.patch \
     file://0009-v4l2-Add-support-for-AV1-decoder.patch \
    "
