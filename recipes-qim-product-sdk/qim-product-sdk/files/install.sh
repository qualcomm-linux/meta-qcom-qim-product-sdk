#!/bin/bash

# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

SDK_NAME="QIM_PRODUCT_SDK"

FOUND_PKGS=""
PKG_LIST_FILE="/opt/qcom/qimpsdk/${SDK_NAME}.list"

# Defaults (can be overridden via flag or env)
INCLUDE_DBG=${INCLUDE_DBG:-false}

# usage/help
usage() {
    cat <<EOF
Usage: $0 [--include-dbg] [-h|--help]

Options:
  --include-dbg   Include *-dbg_*.ipk packages in installation (default excludes them).
  -h, --help      Show this help and exit.

Environment:
  INCLUDE_DBG=true|false   Same as passing/not passing --include-dbg (flag overrides).
EOF
}

# check permission for execute this script
function check_permission() {
    if [ "$(whoami)" != "root" ]; then
        echo "ERROR: need root permission"
        exit 1
    fi
}

# scan packages in current path
function scan_qim_prod_packages() {
    local exclude_patterns="-dev_ -doc_ -locale- -src_ -staticdev_"
    if [ "$INCLUDE_DBG" != true ]; then
        exclude_patterns="$exclude_patterns -dbg_"
    fi

    FOUND_PKGS=$(
        find . -name "*.ipk" \
        | grep -vE -- "$(echo "$exclude_patterns" | sed 's/ /|/g')" \
        | tr '\n' ' '
    )
}

# install packages and save list to file
function install_qim_prod_packages() {

    install_command="opkg install --force-reinstall --force-depends --force-overwrite"

    for PKG_FILE in ${FOUND_PKGS}; do
        ${install_command} ${PKG_FILE}
    done

    rm -f "${PKG_LIST_FILE}"

    for pkg in ${FOUND_PKGS}; do
        pkg_name=`echo ${pkg} | awk -F'/' '{print $NF}' | awk -F'_' '{print $1}'`
        echo ${pkg_name} >> ${PKG_LIST_FILE}
    done
}

function main() {

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>> Install scripts for ${SDK_NAME}"
    echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    echo

    check_permission

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --include-dbg) INCLUDE_DBG=true; shift ;;
            -h|--help) usage; exit 0 ;;
            *) echo "ERROR: Unknown option: $1"; usage; exit 2 ;;
        esac
    done

    if [ -f ${PKG_LIST_FILE} ]; then
        printf "WARN: ${SDK_NAME} has installed, "
        while true; do
            read -p "Do you wish to install anyway? (Y/N)" yn
            case $yn in
                [Yy]* ) break;;
                [Nn]* ) exit 1;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi

    scan_qim_prod_packages

    mkdir -p /opt/qcom/qimpsdk

    install_qim_prod_packages

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>> Installation done for ${SDK_NAME} at root"
    echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    echo
}

main "$@"
