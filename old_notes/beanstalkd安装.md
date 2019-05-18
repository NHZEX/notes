# beanstalkd

sudo apt-get install beanstalkd 安装的是旧版本不推荐

```bash
mkdir beanstalkd && cd beanstalkd
git clone https://github.com/kr/beanstalkd.git
make
make install PREFIX=/usr
```

beanstalk 默认配置限制
/etc/default/beanstalkd
```
## Defaults for the beanstalkd init script, /etc/init.d/beanstalkd on
## Debian systems.

BEANSTALKD_LISTEN_ADDR=127.0.0.1
BEANSTALKD_LISTEN_PORT=11300

# You can use BEANSTALKD_EXTRA to pass additional options. See beanstalkd(1)
# for a list of the available options. Uncomment the following line for
# persistent job storage.
#BEANSTALKD_EXTRA="-b /var/lib/beanstalkd"
```

beanstalkd 启动文件
vim /etc/init.d/beanstalkd
BEANSTALKD_EXTRA="-b /var/log/beanstalkd/binlog"

使用pm2管理状态
```bash
# 设置服务端常驻
pm2 start -x '/usr/bin/beanstalkd' -- -l 0.0.0.0
# 存储持久设置
pm2 dump
```
