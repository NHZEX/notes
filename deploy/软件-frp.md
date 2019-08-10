https://github.com/fatedier/frp/releases

[参考1](https://github.com/fatedier/frp/blob/master/README_zh.md#%E9%80%9A%E8%BF%87%E8%87%AA%E5%AE%9A%E4%B9%89%E5%9F%9F%E5%90%8D%E8%AE%BF%E9%97%AE%E9%83%A8%E7%BD%B2%E4%BA%8E%E5%86%85%E7%BD%91%E7%9A%84-web-%E6%9C%8D%E5%8A%A1)

设置服务器配置文件
### frps.ini
```ini
[common]
# 系统服务
bind_addr = 0.0.0.0
bind_port = 0000
token = @token

# 管理后台
dashboard_port = 000
dashboard_user = admin
dashboard_pwd = admin

# http服务端口
vhost_http_port = 0000

# 多路复用
tcp_mun = true

# 设置顶级域名
subdomain_host = www.qq.com
```

设置客户端配置文件
### frpc.ini
```ini
[common]
# 系统服务
server_addr = 192.168.1.1
server_port = 0000
token = @token

# 多路复用
tcp_mun = true

admin_addr = 0.0.0.0 
admin_port = 0000
admin_user = admin
admin_passwd = admin

[web]
type = http
local_port = 80
use_compression = true
subdomain = 3ww
custom_domains = 3ww.web.test
header_X-From-Where = frp

```

配置常驻后台
```bash
# 转到超管
su
# 设置服务端常驻
sudo pm2 start -x '~/frp/frps' -- -c ~/frp/frps.ini
# 设置客户端常驻
sudo pm2 start -x '~/frp/frpc' -- -c ~/frp/frpc.ini
sudo pm2 start -x './frpc' -- -c ./frpc.ini
# 存储持久设置
pm2 dump

```
