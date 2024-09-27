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
    gstd:do_package_write_ipk \
    gstreamer1.0:do_package_write_ipk \
    gstreamer1.0-python:do_package_write_ipk \
    gstreamer1.0-plugins-base:do_package_write_ipk \
    gstreamer1.0-plugins-good:do_package_write_ipk \
    gstreamer1.0-plugins-bad:do_package_write_ipk \
    gstreamer1.0-rtsp-server:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-base:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-tools:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-batch:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-metamux:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-metatransform:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mldemux:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlmeta:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlmetaparser:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvconverter:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvclassification:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvsuperresolution:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvdetection:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvpose:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-mlvsegmentation:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-msgbroker:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-overlay:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-qmmfsrc:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-redissink:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-rtspbin:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-smartvencbin:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-socket:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-vcomposer:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-voverlay:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-vsplit:do_package_write_ipk \
    qcom-gstreamer1.0-plugins-oss-vtransform:do_package_write_ipk \
    qcom-gstreamer1.0-oss-python-examples:do_package_write_ipk \
  "

GST_PLUGINS:remove:qcs9100 = " \
    qcom-gstreamer1.0-plugins-oss-qmmfsrc:do_package_write_ipk \
  "

GST_SAMPLE_APPS = " \
    qcom-gst-sample-apps-utils:do_package_write_ipk \
    qcom-gst-activate-deactivate-streams-runtime:do_package_write_ipk \
    qcom-gst-add-remove-streams-runtime:do_package_write_ipk \
    qcom-gst-add-streams-as-bundle-example:do_package_write_ipk \
    qcom-gst-ai-classification:do_package_write_ipk \
    qcom-gst-ai-daisychain-detection-classification:do_package_write_ipk \
    qcom-gst-ai-daisychain-detection-pose:do_package_write_ipk \
    qcom-gst-ai-monodepth:do_package_write_ipk \
    qcom-gst-ai-multi-input-output-object-detection:do_package_write_ipk \
    qcom-gst-ai-multistream-inference:do_package_write_ipk \
    qcom-gst-ai-object-detection:do_package_write_ipk \
    qcom-gst-ai-parallel-inference:do_package_write_ipk \
    qcom-gst-ai-pose-detection:do_package_write_ipk \
    qcom-gst-ai-segmentation:do_package_write_ipk \
    qcom-gst-ai-superresolution:do_package_write_ipk \
    qcom-gst-appsink-example:do_package_write_ipk \
    qcom-gst-audio-decode-example:do_package_write_ipk \
    qcom-gst-audio-encode-example:do_package_write_ipk \
    qcom-gst-audio-video-encode:do_package_write_ipk \
    qcom-gst-audio-video-playback:do_package_write_ipk \
    qcom-gst-camera-burst-capture-example:do_package_write_ipk \
    qcom-gst-camera-metadata-example:do_package_write_ipk \
    qcom-gst-camera-shdr-ldc-eis-example:do_package_write_ipk \
    qcom-gst-camera-single-stream-example:do_package_write_ipk \
    qcom-gst-camera-switch-example:do_package_write_ipk \
    qcom-gst-concurrent-videoplay-composition:do_package_write_ipk \
    qcom-gst-multi-camera-example:do_package_write_ipk \
    qcom-gst-multi-stream-example:do_package_write_ipk \
    qcom-gst-smartcodec-example:do_package_write_ipk \
    qcom-gst-snapshot-stream-example:do_package_write_ipk \
    qcom-gst-transform-example:do_package_write_ipk \
    qcom-gst-usb-single-camera-app:do_package_write_ipk \
    qcom-gst-videocodec-concurrent-playback:do_package_write_ipk \
    qcom-gst-video-playback-example:do_package_write_ipk \
    qcom-gst-video-transcode-example:do_package_write_ipk \
    qcom-gst-webrtc-sendrecv-example:do_package_write_ipk \
    qcom-gst-weston-composition-example:do_package_write_ipk \
    qcom-gst-ai-multistream-batch-inference:do_package_write_ipk \
  "

GST_SAMPLE_APPS:remove:qcs9100 = " \
    qcom-gst-activate-deactivate-streams-runtime:do_package_write_ipk \
    qcom-gst-add-remove-streams-runtime:do_package_write_ipk \
    qcom-gst-add-streams-as-bundle-example:do_package_write_ipk \
    qcom-gst-appsink-example:do_package_write_ipk \
    qcom-gst-audio-decode-example:do_package_write_ipk \
    qcom-gst-audio-encode-example:do_package_write_ipk \
    qcom-gst-audio-video-encode:do_package_write_ipk \
    qcom-gst-audio-video-playback:do_package_write_ipk \
    qcom-gst-camera-burst-capture-example:do_package_write_ipk \
    qcom-gst-camera-metadata-example:do_package_write_ipk \
    qcom-gst-camera-shdr-ldc-eis-example:do_package_write_ipk \
    qcom-gst-camera-single-stream-example:do_package_write_ipk \
    qcom-gst-camera-switch-example:do_package_write_ipk \
    qcom-gst-multi-camera-example:do_package_write_ipk \
    qcom-gst-multi-stream-example:do_package_write_ipk \
    qcom-gst-snapshot-stream-example:do_package_write_ipk \
    qcom-gst-usb-single-camera-app:do_package_write_ipk \
    qcom-gst-video-playback-example:do_package_write_ipk \
    qcom-gst-webrtc-sendrecv-example:do_package_write_ipk \
    qcom-gst-weston-composition-example:do_package_write_ipk \
  "

addtask do_generate_qim_sdk_setscene
do_generate_qim_sdk[sstate-inputdirs] = "${SSTATE_IN_DIR}"
do_generate_qim_sdk[sstate-outputdirs] = "${SSTATE_OUT_DIR}"
do_generate_qim_sdk[dirs] = "${SSTATE_IN_DIR} ${SSTATE_OUT_DIR}"
do_generate_qim_sdk[cleandirs] = "${SSTATE_IN_DIR} ${SSTATE_OUT_DIR}"
do_generate_qim_sdk[stamp-extra-info] = "${MACHINE_ARCH}"
do_generate_qim_sdk[depends] = " \
    qcom-qim-sdk:do_patch \
    gdk-pixbuf:do_package_write_ipk \
    hiredis:do_package_write_ipk \
    json-glib:do_package_write_ipk \
    liba52:do_package_write_ipk \
    libdaemon:do_package_write_ipk \
    libgudev:do_package_write_ipk \
    lame:do_package_write_ipk \
    libnice:do_package_write_ipk \
    libpsl:do_package_write_ipk \
    librsvg:do_package_write_ipk \
    libsoup-2.4:do_package_write_ipk \
    libsrtp:do_package_write_ipk \
    libtheora:do_package_write_ipk \
    libwebp:do_package_write_ipk \
    mpg123:do_package_write_ipk \
    orc:do_package_write_ipk \
    sbc:do_package_write_ipk \
    speex:do_package_write_ipk \
    srt:do_package_write_ipk \
    taglib:do_package_write_ipk \
    mosquitto:do_package_write_ipk \
    ${GST_PLUGINS} \
    ${GST_SAMPLE_APPS} \
  "


# Add a task to generate QIM sdk
do_generate_qim_sdk () {
    # generate QIM SDK package
    if [ -d ${TMP_SSTATE_IN_DIR}/${SDK_PN} ]; then
        rm -rf ${TMP_SSTATE_IN_DIR}/${SDK_PN}/
    fi
    mkdir -p ${TMP_SSTATE_IN_DIR}/${SDK_PN}/
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
                "liborc-0", "libsbc1", "libspeex1", "libtag1", "libjson-glib-1.0-0",
                "libmosquitto1", "libhiredis1.0.0", "libnice_0.1.18", "libsrtp2-1_2.4.2",
                "libsrt1.4_1.4.4"]
    for _, pkgdirs, _ in os.walk(os.path.join(deploydir, pkgtype)):
        for pkgdir in pkgdirs:
            for f in os.listdir(os.path.join(deploydir, pkgtype, pkgdir)):
                if "gstreamer" in os.path.basename(f) or "libgst" in os.path.basename(f) or "gstd" in os.path.basename(f) or "gst" in os.path.basename(f):
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
