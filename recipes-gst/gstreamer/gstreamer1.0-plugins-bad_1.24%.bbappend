FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-bad/1.24:"

SRC_URI:append:qcom-custom-bsp = "\
  file://0001-gstreamer1.0-plugins-bad-Add-meson-option-to-build-a.patch \
"

PACKAGECONFIG:append:qcom-custom-bsp = " webrtc sctp srt srtp"
DEPENDS:append:qcom:qcom-custom-bsp = " libnice libsrtp srt"
