- 第一步（编辑 systemd 文件，禁用默认监听）

```vim /etc/systemd/system/docker.service.d/docker.conf```
```config
[Service]
    ExecStart=
    ExecStart=/usr/bin/dockerd
```

- 第二部（编辑配置文件）
```vim /etc/docker/daemon.json```

样式一
```json
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2379"]
}
```

样式二
```json
{
  "hosts": ["fd://", "tcp://127.0.0.1:2379"]
}
```

- 第三步（重载配置文件）
```systemctl daemon-reload```

- 第四步（重启docker）
```systemctl restart docker```

## 日志的查看方法
```bash
journalctl -u docker.service
```
