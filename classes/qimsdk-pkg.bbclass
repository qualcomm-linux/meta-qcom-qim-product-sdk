# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=7a434440b651f4a472ca93716d01033a"

SSTATETASKS += "do_generate_qim_sdk "
SSTATE_OUT_DIR:${MACHINE} = "${DEPLOY_DIR}/qimsdk_artifacts/${MACHINE}/"
SSTATE_IN_DIR = "${TOPDIR}/${SDK_PN}"
TMP_SSTATE_IN_DIR = "${TOPDIR}/${SDK_PN}_tmp"

python __anonymous () {
    package_type = d.getVar("IMAGE_PKGTYPE", True)
    if package_type == "ipk":
        bb.build.addtask('do_generate_qim_sdk', 'do_package_write_ipk', 'do_packagedata' , d)
}

GST_PLUGINS = " \
    gstreamer1.0:do_package_write_ipk \
    gstreamer1.0-plugins-base:do_package_write_ipk \
    gstreamer1.0-plugins-good:do_package_write_ipk \
    gstreamer1.0-plugins-bad:do_package_write_ipk \
    gstreamer1.0-rtsp-server:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-base:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-tools:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-batch:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-metamux:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mldemux:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlmeta:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvconverter:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvclassification:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvsuperresolution:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvdetection:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvpose:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvsegmentation:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-overlay:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-qmmfsrc:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-socket:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vcomposer:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vsplit:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vtransform:do_package_write_ipk \
    gstreamer1.0-qcom-oss-sample-apps:do_package_write_ipk \
  "

GST_PLUGINS:remove:qcs9100 = " \
    gstreamer1.0-plugins-qcom-oss-base:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-tools:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-batch:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-metamux:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mldemux:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlmeta:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvconverter:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvclassification:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvsuperresolution:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvdetection:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvpose:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-mlvsegmentation:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-overlay:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-qmmfsrc:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-socket:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vcomposer:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vsplit:do_package_write_ipk \
    gstreamer1.0-plugins-qcom-oss-vtransform:do_package_write_ipk \
    gstreamer1.0-qcom-oss-sample-apps:do_package_write_ipk \
  "

addtask do_generate_qim_sdk_setscene
do_generate_qim_sdk[sstate-inputdirs] = "${SSTATE_IN_DIR}"
do_generate_qim_sdk[sstate-outputdirs] = "${SSTATE_OUT_DIR}"
do_generate_qim_sdk[dirs] = "${SSTATE_IN_DIR} ${SSTATE_OUT_DIR}"
do_generate_qim_sdk[cleandirs] = "${SSTATE_IN_DIR} ${SSTATE_OUT_DIR}"
do_generate_qim_sdk[stamp-extra-info] = "${MACHINE_ARCH}"
do_generate_qim_sdk[depends] = " \
    qim-sdk:do_patch \
    gdk-pixbuf:do_package_write_ipk \
    liba52:do_package_write_ipk \
    libdaemon:do_package_write_ipk \
    libgudev:do_package_write_ipk \
    lame:do_package_write_ipk \
    libpsl:do_package_write_ipk \
    librsvg:do_package_write_ipk \
    libsoup-2.4:do_package_write_ipk \
    libtheora:do_package_write_ipk \
    libwebp:do_package_write_ipk \
    mpg123:do_package_write_ipk \
    orc:do_package_write_ipk \
    sbc:do_package_write_ipk \
    speex:do_package_write_ipk \
    taglib:do_package_write_ipk \
    ${GST_PLUGINS} \
  "


# Add a task to generate QIM sdk
do_generate_qim_sdk () {
    # generate QIM SDK package
    if [ ! -d ${TMP_SSTATE_IN_DIR}/${SDK_PN} ]; then
        mkdir -p ${TMP_SSTATE_IN_DIR}/${SDK_PN}/
    fi
    cp -r ${WORKDIR}/*install.sh ${TMP_SSTATE_IN_DIR}/${SDK_PN}/
    PKG_LISTS="${@get_pkgs_list(d)}"
    for pkg in "${PKG_LISTS}"
    do
        cp ${pkg} ${TMP_SSTATE_IN_DIR}/${SDK_PN}/
    done

    cd ${TMP_SSTATE_IN_DIR}
    tar -zcf ${SSTATE_IN_DIR}/${SDK_PN}_${PV}.tar.gz ./${SDK_PN}/*
    mkdir -p ./${SDK_PN}/dev/
    for f in `find . -type f \( -name "*-dev_*" \)`
    do
        mv $f ./${SDK_PN}/dev/
    done
    tar -zcf ${SSTATE_IN_DIR}/${SDK_PN}-dev_${PV}.tar.gz ./${SDK_PN}/dev/*
    rm -rf ./${SDK_PN}/dev
    mkdir -p ./${SDK_PN}/dbg/
    for f in `find . -type f \( -name "*-dbg_*" \)`
    do
        mv $f ./${SDK_PN}/dbg/
    done
    tar -zcf ${SSTATE_IN_DIR}/${SDK_PN}-dbg_${PV}.tar.gz ./${SDK_PN}/dbg/*
    rm -rf ./${SDK_PN}/dbg
    for f in `find . -type f \( -name "*-doc_*" -o -name "*-staticdev_*" \)`
    do
        rm -rf $f
    done
    for f in `find . -type f \( -name "*-locale-*" -o -name "*-src_*" \)`
    do
        rm -rf $f
    done

    tar -zcf ${SSTATE_IN_DIR}/${SDK_PN}-rel_${PV}.tar.gz ./${SDK_PN}/*
    rm -rf ${TMP_SSTATE_IN_DIR}
}

def get_pkgs_list(d):
    import os
    pkgtype = d.getVar("IMAGE_PKGTYPE", True)
    deploydir = d.getVar("DEPLOY_DIR", True)
    timestampfile = os.path.join(deploydir, "qimsdk-timestamp")
    pkgslist = []
    dep_list = ["libgdk-pixbuf-2.0-0", "liba52-0", "a52"
                "libdaemon0", "libgudev-1.0-0", "lame_", "libmp3lame0",
                "libpsl5", "librsvg-2-2", "libsoup-2.4_",
                "libtheora_", "libwebp_", "mpg123_",
                "liborc-0", "libsbc1", "libspeex1", "libtag1"]
    for _, pkgdirs, _ in os.walk(os.path.join(deploydir, pkgtype)):
        for pkgdir in pkgdirs:
            for f in os.listdir(os.path.join(deploydir, pkgtype, pkgdir)):
                if "gstreamer" in os.path.basename(f) or "libgst" in os.path.basename(f) :
                    pkgslist.append(os.path.join(deploydir, pkgtype, pkgdir, f))
                else:
                    for dep in dep_list:
                        if dep in os.path.basename(f):
                            pkgslist.append(os.path.join(deploydir, pkgtype, pkgdir, f))
                            dep_list.remove(dep)

    return " \\\n ".join(pkgslist)

python do_generate_qim_sdk_setscene() {
    sstate_setscene(d)
}

RM_WORK_EXCLUDE += "${PN}"
