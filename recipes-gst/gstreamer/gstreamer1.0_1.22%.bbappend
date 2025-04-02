FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0/1.22:"

SRC_URI:append:qcom-custom-bsp = "\
    file://0001-meta-add-aggregation-function-for-allocation-meta-ap.patch \
"
