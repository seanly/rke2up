#!/bin/bash

set -x

_rke2_version=${1:-v1.26.10+rke2r1}
shift

# format: https://github.com/rancher/rke2/releases/download/v1.26.10%2Brke2r1/rke2-images-all.linux-amd64.txt

## files: 
## - sha256sum-amd64.txt
## - rke2.linux-amd64.tar.gz
## - rke2-images-core.linux-amd64.tar.gz
## - rke2-images-cilium.linux-amd64.tar.gz
## - rke2-images-calico.linux-amd64.tar.gz

_release_baseurl=https://github.com/rancher/rke2/releases/download
_images_list_file=rke2-images-all.linux-amd64.txt
_url_encode_release=$(echo "$_rke2_version"|sed 's/+/%2B/g')

 _release_dir=$(pwd)/$_rke2_version
 mkdir -p ${_release_dir}/images
 mkdir -p ${_release_dir}/artifacts

do_download_verify_file() {
    _sha256sum_file=sha256sum-amd64.txt

    _target_url=${_release_baseurl}/${_url_encode_release}/${_sha256sum_file}
    curl -sfL $_target_url > ${_release_dir}/artifacts/${_sha256sum_file}
}

do_download_rke2() {
    _rke2_package_file=rke2.linux-amd64.tar.gz

    _target_url=${_release_baseurl}/${_url_encode_release}/${_rke2_package_file}
    curl -sfL $_target_url > ${_release_dir}/artifacts/${_rke2_package_file}
}

do_download_rke2_core_images() {
    _rke2_core_images=rke2-images-core.linux-amd64.tar.gz

    _target_url=${_release_baseurl}/${_url_encode_release}/${_rke2_core_images}
    curl -sfL $_target_url > ${_release_dir}/images/${_rke2_core_images}
}

do_download_rke2_calico_images() {
    _rke2_calico_images=rke2-images-calico.linux-amd64.tar.gz

    _target_url=${_release_baseurl}/${_url_encode_release}/${_rke2_calico_images}
    curl -sfL $_target_url > ${_release_dir}/images/${_rke2_calico_images}
}

do_download_rke2_cilium_images() {
    _rke2_cilium_images=rke2-images-cilium.linux-amd64.tar.gz

    _target_url=${_release_baseurl}/${_url_encode_release}/${_rke2_cilium_images}
    curl -sfL $_target_url > ${_release_dir}/images/${_rke2_cilium_images}
}

do_download_verify_file
do_download_rke2
do_download_rke2_core_images
do_download_rke2_calico_images
do_download_rke2_cilium_images