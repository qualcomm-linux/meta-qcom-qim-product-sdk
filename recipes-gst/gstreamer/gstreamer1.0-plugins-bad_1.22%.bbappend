FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-bad/1.22:"

SRC_URI:append:qcom-custom-bsp = "\
  file://0001-wayland-Add-support-for-NV12_Q08C-compressed-8-bit-f.patch \
  file://0002-Hack-wayland-Add-NV12_Q08C-to-shm-formats.patch \
"

PACKAGECONFIG:append:qcom-custom-bsp = " webrtc sctp srt srtp"
DEPENDS:append:qcom:qcom-custom-bsp = " libnice libsrtp srt"

