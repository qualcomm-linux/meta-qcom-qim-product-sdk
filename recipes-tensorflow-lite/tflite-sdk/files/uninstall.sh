#!/bin/bash

# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

SDK_NAME="TFLITE_SDK"

FOUND_PKGS=""
PKG_LIST_DIR="/opt/qcom/tflite/"
PKG_LIST_FILE="${PKG_LIST_DIR}/${SDK_NAME}.list"
IS_DEB=0

# check permission for execute this script
function check_permission() {
    if [ "$(whoami)" != "root" ]; then
        echo "ERROR: need root permission"
        exit 1
    fi
}

# scan packages in current path
function scan_tflite_packages() {
    FOUND_PKGS=`find . -name "*.ipk" \
        | grep -v "\-dbg_" \
        | grep -v "\-dev_" \
        | grep -v "\-staticdev_" \
        | tr '\n' ' '`
    if [[ -z "${FOUND_PKGS}" ]]; then
        FOUND_PKGS=`find . -name "*.deb" \
            | grep -v "\-dbg_" \
            | grep -v "\-dev_" \
            | grep -v "\-staticdev_" \
            | tr '\n' ' '`
        IS_DEB=1
    fi
}

function main() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>> Uninstall scripts for $SDK_NAME"
    echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    echo

    check_permission

    if [ ! -f $PKG_LIST_FILE ]; then
        echo "ERROR: $SDK_NAME has not installed"
        exit 1
    fi

    scan_tflite_packages

    uninstall_command="opkg remove --force-depends --force-remove"
    if [[ ${IS_DEB} == 1 ]]; then
        uninstall_command="dpkg -r --force-depends"
    fi
    for pkg in `cat $PKG_LIST_FILE`; do
        $uninstall_command $pkg
    done

    rm -rf $PKG_LIST_FILE
    rm -rf ${PKG_LIST_DIR}
}

main "$@"