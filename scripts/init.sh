#!/bin/bash

set -eux

export INSTALL_RKE2_VERSION=v1.23.17+rke2r1
export INSTALL_RKE2_METHOD=tar
export INSTALL_RKE2_ARTIFACT_PATH=$(pwd)/${INSTALL_RKE2_VERSION}/artifacts
export INSTALL_RKE2_AGENT_IMAGES_DIR=$(pwd)/${INSTALL_RKE2_VERSION}/images

mkdir -p /etc/rancher/rke2
mkdir -p /var/lib/rancher/rke2/agent/images

INSTALL_RKE2_TYPE=$1

rsync -av ./${INSTALL_RKE2_TYPE}/etc/config.yaml /etc/rancher/rke2/
rsync -av ${INSTALL_RKE2_AGENT_IMAGES_DIR}/ /var/lib/rancher/rke2/agent/images

./scripts/install.sh
