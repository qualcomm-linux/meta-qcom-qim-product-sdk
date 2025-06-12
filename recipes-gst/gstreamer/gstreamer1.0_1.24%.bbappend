FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0/1.24:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-meta-add-aggregation-function-for-allocation-meta-ap.patch \
    file://0002-gstreamer1.0-Add-meson-option-to-build-all-plugins.patch \
"
