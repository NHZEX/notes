## 镜像源

### /etc/apt/sources.list
```
#deb http://ftp.debian.org/debian buster main contrib
deb http://mirrors.ustc.edu.cn/debian buster main contrib
#deb http://ftp.debian.org/debian buster-updates main contrib
deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib

# security updates
#deb http://security.debian.org buster/updates main contrib
deb http://mirrors.ustc.edu.cn/debian-security buster/updates main contrib

#deb http://download.proxmox.wiki/debian/pve buster pve-no-subscription
#deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian buster pve-no-subscription
deb https://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription
```

### /etc/apt/sources.list.d/ceph.list
```
#deb http://download.proxmox.com/debian/ceph-nautilus buster main
deb http://mirrors.ustc.edu.cn/proxmox/debian/ceph-nautilus buster main
```