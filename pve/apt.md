## 镜像源

### /etc/apt/sources.list
```
# deb http://ftp.debian.org/debian bookworm main contrib
deb http://mirrors.ustc.edu.cn/debian bookworm main contrib non-free-firmware

# deb http://ftp.debian.org/debian bookworm-updates main contrib
deb http://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free-firmware
deb http://mirrors.ustc.edu.cn/debian bookworm-backports main contrib non-free-firmware

# security updates
# deb http://security.debian.org bookworm-security main contrib

deb http://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free-firmware

# deb http://download.proxmox.wiki/debian/pve bookworm pve-no-subscription
# deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian bookworm pve-no-subscription
# deb https://mirrors.ustc.edu.cn/proxmox/debian/pve bookworm pve-no-subscription
```

### /etc/apt/sources.list.d/ceph.list
```
#deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
deb http://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription
```

### /etc/apt/sources.list.d/pve-enterprise.list
```
# deb http://download.proxmox.wiki/debian/pve bookworm pve-subscription
deb https://mirrors.ustc.edu.cn/proxmox/debian/pve bookworm pve-no-subscription
```