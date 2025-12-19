require gstreamer1.0-common.inc

PACKAGECONFIG:append:qcom = " webrtc sctp srt srtp"
DEPENDS:append:qcom = " weston libnice libsrtp srt"
