#!/bin/bash

set -x

# format: https://github.com/rancher/rke2/releases/download/v1.26.10%2Brke2r1/rke2-images-all.linux-amd64.txt

_release_baseurl=https://github.com/rancher/rke2/releases/download
_images_list_file=rke2-images-all.linux-amd64.txt

_release_list_file=$1
shift

_release_basedir=$(dirname ${_release_list_file})
_release_list=$(cat $_release_list_file)

for release in $_release_list
do
    _release_dir=${_release_basedir}/$release
    mkdir -p ${_release_dir}
    _encode_release=$(echo "$release"|sed 's/+/%2B/g')
    _target_url=${_release_baseurl}/${_encode_release}/${_images_list_file}
    curl -sfL $_target_url > ${_release_dir}/${_images_list_file}
done