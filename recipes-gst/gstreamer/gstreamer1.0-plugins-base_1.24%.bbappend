FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-base/1.24:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-video-Add-support-for-NV12_Q08C-compressed-8-bit-for.patch \
    file://0002-gstreamer1.0-plugins-base-Add-meson-option-to-build-.patch \
"
