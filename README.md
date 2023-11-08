# rke2-demo

## Install Scripts

```
cd scripts
curl -sfL https://get.rke2.io --output install.sh
```

# TODO

- rke2up (inspired by [k3sup](https://github.com/alexellis/k3sup))

    - stage2: select rke2 version and target host
    - stage1: get airgap package and push package to target host
    - stage3: download install script and push script to target host
    - stage4: run install script on target host

## rke2 version

v1.28.3+rke2r1
v1.27.7+rke2r1
v1.26.10+rke2r1
v1.25.15+rke2r1
v1.24.17+rke2r1
v1.23.17+rke2r1