# Welcome to the Qualcomm Intelligent Multimedia Product SDK (QIMP SDK)

In this documentation, you will learn:

- What is the Qualcomm Intelligent Multimedia Product SDK
- How to sync and build the Qualcomm Intelligent Multimedia Product SDK
- How to install and uninstall the Qualcomm Intelligent Multimedia Product SDK

Let's get started!

# What is the Qualcomm Intelligent Multimedia Product SDK

The Qualcomm Intelligent Multimedia Product SDK is a Product SDK across Internet of Things (IOT) segments encompassing QIM SDK, TF-lite SDK, SNPE SDK and QNN SDK enabling seamless multimedia and AI/ML application deployment. This SDK utilizes GStreamer, an open-source multimedia framework and exposes easy APIs and plugins in both multimedia and AI/ML domain.

The Qualcomm Intelligent Multimedia Product SDK provides advanced features as below:

- APIs and tools for multimedia/AI application development.
- Add your own application recipes based on QIMSDK for multimedia development and use AI acceleration using TFLITE-SDK/QNN/SNPE SDKs.
- Standalone compilation based on Yocto Project.

The Qualcomm Intelligent Multimedia Product SDK consist of :

- recipes: has recipes to build individual qimsdk/tflite/qnn/snpe packages
- packagegroups: has qimsdk/tflite/qnn/snpe packagegroups
- classes: has base and qimsdk/tflite/qnn/snpe packaging classes
- conf: has layer.conf with qimsdk/tflite/qnn/snpe layer specific configurations


# How to sync and build the Qualcomm Intelligent Multimedia Product SDK

## Host Setup and Download the Yocto Project BSP

Refer to [QCOM Linux Yocto BSP releases](https://github.com/qualcomm-linux/qcom-manifest/blob/qcom-linux-scarthgap/README.md) setup the host environment and download Yocto Project BSP.

```shell
mkdir [release]
cd [release]
repo init -u https://github.com/qualcomm-linux/qcom-manifest -b [branch name] -m [release manifest]
repo sync
```

## Examples

To download the `qcom-6.6.58-QLI.1.3.1-Ver.1.0` release

```shell
repo init -u https://github.com/qualcomm-linux/qcom-manifest -b qcom-linux-scarthgap -m qcom-6.6.58-QLI.1.3.1-Ver.1.0
repo sync
```

## Run below command to download "meta-qcom-qim-product-sdk" layer in [release] directory where you have downloaded Yocto Project BSP.

```shell
cd [release]
git clone https://github.com/qualcomm-linux/meta-qcom-qim-product-sdk -b [meta-qcom-qim-product-sdk release tag] layers/meta-qcom-qim-product-sdk
```
Note: Find the latest meta-qcom-qim-product-sdk release tag names at https://github.com/qualcomm-linux/meta-qcom-qim-product-sdk/tags

## Examples

To download the `qcom-6.6.58-QLI.1.3.1-Ver.1.0_qim-product-sdk-1.2.1` release tag
```shell
git clone https://github.com/qualcomm-linux/meta-qcom-qim-product-sdk -b qcom-6.6.58-QLI.1.3.1-Ver.1.0_qim-product-sdk-1.2.1 layers/meta-qcom-qim-product-sdk
```

## Build Yocto Project BSP plus Qualcomm Intelligent Multimedia Product SDK

```shell
export SHELL=/bin/bash
export EXTRALAYERS="meta-qcom-qim-product-sdk"
MACHINE=qcs6490-rb3gen2-vision-kit DISTRO=qcom-wayland source setup-environment
```

Run the following command to compile and generate flashable image with Yocto Project BSP plus QIM Product SDK layers
```shell
bitbake qcom-multimedia-image
```
Image output path: $[release]/build-qcom-wayland/tmp-glibc/deploy/images/qcm6490/qcom-multimedia-image.

## To generate QIM Product SDK artifacts

```shell
bitbake qcom-qim-product-sdk
```
QIM Product SDK output path: $[release]/build-qcom-wayland/tmp-glibc/deploy/qim_prod_sdk_artifacts.

# Flash image

To flash the generated build, see the [Flash images](https://docs.qualcomm.com/bundle/publicresource/topics/80-70017-254/flash_images.html?vproduct=1601111740013072&latest=true)

# Reference

[Standard Yocto environment](https://docs.yoctoproject.org/5.0.6/singleindex.html#welcome-to-the-yocto-project-documentation)

[QCOM Linux Yocto BSP releases](https://github.com/qualcomm-linux/qcom-manifest/blob/qcom-linux-scarthgap/README.md)

# Maintainer(s)
1. Chandra Bothsa <quic_cbothsa@quicinc.com>
2. Gautam Naidu Bodala <quic_gbodala@quicinc.com>
