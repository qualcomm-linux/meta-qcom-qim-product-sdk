FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-base/1.22:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-video-Add-support-for-NV12_Q08C-compressed-8-bit-for.patch \
"
