# rke2up

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

# rke2

## 0 stage

- load ip_vs
```
lsmod | grep ip_vs
ls /lib/modules/$(uname -r)/kernel/net/netfilter/ipvs|grep -o "^[^.]*" > /etc/modules-load.d/ip_vs.conf

```

- network manager configure

https://docs.rke2.io/known_issues#networkmanager

/etc/NetworkManager/conf.d/rke2-canal.conf
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:flannel*
```


## install 


stage1: download rke2up image and export

```
docker save seanly/rke2up:v1.26.10-rke2r1 | gzip > rke2up.tar.gz
```

stage2: send package to target host and decompression

```
gunzip -c rke2up.tar.gz| tar --extract --wildcards --to-stdout '*/layer.tar' | tar --extract --ignore-zeros
```

stage3: run install-rke2.sh server/agent

```
cd rke2
bash install-rke2.sh server
systemctl start rke2-server
# note: close selinux or `setenforce 0`
```

## usage

### cluster token

```
cat /var/lib/rancher/rke2/server/node-token

```

### clean rke2 node

`rke2-killall.sh` and `rke2-uninstall.sh`

### how to access k8s cluster?

```
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
export CONTAINER_RUNTIME_ENDPOINT="unix:///var/run/k3s/containerd/containerd.sock"
export PATH=/var/lib/rancher/rke2/bin:$PATH

# get pod list
kubectl get pod -A

# get container list
crictl ps

```

### how to access etcd cluster ?
```bash
ETCDCTL_ENDPOINTS='https://127.0.0.1:2379' 
ETCDCTL_CACERT='/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt'
ETCDCTL_CERT='/var/lib/rancher/rke2/server/tls/etcd/server-client.crt'
ETCDCTL_KEY='/var/lib/rancher/rke2/server/tls/etcd/server-client.key' 
ETCDCTL_API=3
etcdctl endpoint status --cluster -w table
```
