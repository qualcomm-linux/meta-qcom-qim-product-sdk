FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-good/1.22:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-v4l2-Add-support-for-V4L2_PIX_FMT_QC08C-format.patch \
    file://0002-v4l2-Check-for-V4L2_BUF_FLAG_LAST-flag-to-handle-EOS.patch \
    file://0003-v4l2-Set-pixel-format-to-HEVC-for-H265-MIME-type.patch \
    file://0004-v4l2-Add-support-for-fd-memory-import.patch \
    file://0005-v4l2-Add-support-for-AV1-format.patch \
    file://0006-v4l2-decoder-Prefer-colorimetry-from-acquired-caps-f.patch \
    file://0007-v4l2-enc-Set-sink-format-before-src-format.patch \
    file://0008-v4l2-Update-video-alignment-in-pool-config.patch \
    file://0009-v4l2-Drop-empty-bytesused-0-buffers.patch \
"
