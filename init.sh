#!/bin/bash

set -eux

export INSTALL_RKE2_VERSION=v1.23.17+rke2r1
export INSTALL_RKE2_METHOD=tar
export INSTALL_RKE2_ARTIFACT_PATH=$(pwd)/v1.23/artifacts
export INSTALL_RKE2_AGENT_IMAGES_DIR=$(pwd)/v1.23/images

mkdir -p /etc/rancher/rke2
mkdir -p /var/lib/rancher/rke2/agent/images

rsync -av ./etc/config.yaml /etc/rancher/rke2/
rsync -av ${INSTALL_RKE2_AGENT_IMAGES_DIR}/ /var/lib/rancher/rke2/agent/images

./install.sh
