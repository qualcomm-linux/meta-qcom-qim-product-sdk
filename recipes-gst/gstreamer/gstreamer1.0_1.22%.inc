FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/gstreamer1.0/1.22:"

SRC_URI:append = "\
    file://0001-meta-add-aggregation-function-for-allocation-meta-ap.patch \
"
