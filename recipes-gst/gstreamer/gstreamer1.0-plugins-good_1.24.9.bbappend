FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-good/1.24.9:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-v4l2-Add-support-for-V4L2_PIX_FMT_QC08C-format.patch \
    file://0002-v4l2-Check-for-V4L2_BUF_FLAG_LAST-flag-to-handle-EOS.patch \
    file://0003-v4l2-Set-pixel-format-to-HEVC-for-H265-MIME-type.patch \
    file://0004-v4l2-Add-support-for-fd-memory-import.patch \
    file://0005-v4l2-Add-support-for-AV1-format.patch \
    file://0006-v4l2-decoder-Prefer-colorimetry-from-acquired-caps-f.patch \
    file://0007-v4l2-enc-Set-sink-format-before-src-format.patch \
    file://0008-gstreamer1.0-plugins-good-Add-meson-option-to-build-.patch \
    file://0009-v4l2-Use-internal-DMA-buffer-pool-even-without-video.patch \
    file://0010-v4l2-fix-runtime-change-between-system-and-DMA-buffe.patch \
    file://0011-v4l2-Send-video-alignment-in-allocation-query.patch \
    file://0012-v4l2-Drop-empty-bytesused-0-buffers.patch \
    file://0013-v4l2-Add-KEEP_MAPPED-flag-to-the-allocated-buffers.patch \
    file://0014-v4l2-Handle-GAP-buffer-in-encoder.patch \
    file://0015-v4l2-Set-extra-controls-if-pixelformat-is-updated.patch \
    file://0016-v4l2-Fix-segmentation-fault.patch \
    file://0017-v4l2-consider-Q08C-as-contiguous-planes.patch \
    file://0018-v4l2-Make-the-extra-controls-property-dynamic.patch \
    file://0019-v4l2-Add-support-for-colorimetry-bt2100-pq-and-1-4-5.patch \
    file://0020-v4l2-Enable-copy-at-threshold-for-encoder-output.patch \
"
