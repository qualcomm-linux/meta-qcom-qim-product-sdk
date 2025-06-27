FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-bad/1.24.2:"

SRC_URI:append:qcom-custom-bsp = "\
  file://0001-gstreamer1.0-plugins-bad-Add-meson-option-to-build-a.patch \
  file://0002-waylandsink-release-pending-buffers-in-composer.patch \
  file://0003-waylandsink-support-gap-buffers.patch \
  file://0004-waylandsink-increase-timeout-limitation-in-gst_wl_wi.patch \
  file://0005-wayland-Add-support-for-NV12_Q08C-compressed-8-bit-f.patch \
  file://0006-Hack-wayland-Add-NV12_Q08C-to-shm-formats.patch \
"

PACKAGECONFIG:append:qcom-custom-bsp = " webrtc sctp srt srtp"
DEPENDS:append:qcom:qcom-custom-bsp = " libnice libsrtp srt"
