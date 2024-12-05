DEPENDS:append:qcom-custom-bsp = " qemu-native"
DEPENDS:append:qcs9100 = " qcom-displaydlkm"
DEPENDS:append:qcs8300 = " qcom-displaydlkm"
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
     file://0010-v4l2-Fix-incorrect-allocator-creation.patch \
     file://0011-v4l2-Add-KEEP_MAPPED-flag-to-the-pool.patch \
     file://0012-v4l2-Add-support-for-UBWC-format-on-CAPTURE-plane.patch \
    "
