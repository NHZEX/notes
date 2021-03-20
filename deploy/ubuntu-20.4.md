## Dns 设置

- https://askubuntu.com/a/1288859

nano /etc/netplan/01-netcfg.yaml

```yml
network:
  ethernets:
    eth0:
      dhcp4: true
        nameservers:
          addresses: [8.8.8.8, 8.8.4.4]
```
```bash
sudo netplan apply
systemd-resolve --status
```