#!/bin/bash

set -eux

export INSTALL_RKE2_VERSION=${1:v1.26.10+rke2r1}
shift

export INSTALL_RKE2_TYPE=$1
shift

export INSTALL_RKE2_METHOD=tar
export INSTALL_RKE2_ARTIFACT_PATH=$(pwd)/${INSTALL_RKE2_VERSION}/artifacts
export INSTALL_RKE2_AGENT_IMAGES_DIR=$(pwd)/${INSTALL_RKE2_VERSION}/images


## stage1: init dir
_rke2_etc_path=/etc/rancher/rke2
_rke2_images_path=/var/lib/rancher/rke2/agent/images
mkdir -p ${_rke2_etc_path}
mkdir -p ${_rke2_images_path}

## stage2: copy config

rsync -av ./etc/${INSTALL_RKE2_TYPE}/config.yaml ${_rke2_etc_path}

## stage3: copy local images
rsync -av ${INSTALL_RKE2_AGENT_IMAGES_DIR}/ ${_rke2_images_path}

## stage4: install cluster

./scripts/install.sh
