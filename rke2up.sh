#!/bin/bash

set -eux

SCRIPT_FILE=$(readlink -f $0)
CURRENT_DIR=$(dirname $SCRIPT_FILE)

export INSTALL_RKE2_TYPE=${1:-server}
export INSTALL_RKE2_VERSION=${2:-v1.26.10+rke2r1}

export INSTALL_RKE2_METHOD=tar
export INSTALL_RKE2_ARTIFACT_PATH=${CURRENT_DIR}/${INSTALL_RKE2_VERSION}/artifacts
export INSTALL_RKE2_AGENT_IMAGES_DIR=${CURRENT_DIR}/${INSTALL_RKE2_VERSION}/images

## stage1: init dir
_rke2_etc_path=/etc/rancher/rke2
_rke2_images_path=/var/lib/rancher/rke2/agent/images
_rke2_manifests_path=/var/lib/rancher/rke2/server/manifests/
mkdir -p ${_rke2_etc_path}
mkdir -p ${_rke2_images_path}
mkdir -p ${_rke2_manifests_path}

## stage2: copy config
rsync -av ./etc/${INSTALL_RKE2_TYPE}/config.yaml ${_rke2_etc_path}

## stage3: copy local images
rsync -av ${INSTALL_RKE2_AGENT_IMAGES_DIR}/ ${_rke2_images_path}

## stage4: copy manifests
rsync -av ./manifests/ ${_rke2_manifests_path}

## stage5: install cluster
bash ${CURRENT_DIR}/lib/install.sh

modprobe ip_vs
modprobe ip_vs_rr 
modprobe ip_vs_wrr
modprobe ip_vs_sh

systemctl start rke2-${INSTALL_RKE2_TYPE}
journalctl -f -u rke2-${INSTALL_RKE2_TYPE}