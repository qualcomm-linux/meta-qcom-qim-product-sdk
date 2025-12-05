FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/gstreamer1.0-plugins-base/1.26:"

SRC_URI:append:qcom = "\
    file://0001-video-Add-support-for-NV12_Q08C-compressed-8-bit-for.patch \
    file://0002-gstreamer1.0-plugins-base-Add-meson-option-to-build-.patch \
    file://0003-meta-add-aggregation-function-for-allocation-meta-ap.patch \
    file://0004-videometa-Update-the-aggregation-logic-for-stride-al.patch \
    file://0005-video-Add-support-for-NV12_Q10LE32C-compressed-10-bi.patch \
    file://0006-videorate-Set-passthrough-only-mode-for-videorate-pl.patch \
"
