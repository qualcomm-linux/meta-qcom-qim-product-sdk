#!/bin/bash

# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

SDK_NAME="QIM_SDK"

PKG_LIST_FILE="/opt/qcom/qimsdk/${SDK_NAME}.list"
QIM_PKG_DIR = "/opt/qcom/qimsdk/"

# check permission for execute this script
function check_permission() {
    if [ "$(whoami)" != "root" ]; then
        echo "ERROR: need root permission"
        exit 1
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

    uninstall_command="opkg remove --force-depends --force-remove"
    for pkg in `cat $PKG_LIST_FILE`; do
        $uninstall_command $pkg
    done

    rm -rf $PKG_LIST_FILE
    rm -rf ${QIM_PKG_DIR}
}

main "$@"

