```bash
# node-agent
./deploy_env.sh 0.0.0.0

# swoole-tracker
DEV_PHP_VER="7.3"
sudo cp swoole_tracker${DEV_PHP_VER//./}.so `php-config${DEV_PHP_VER} --extension-dir`/swoole_tracker.so
echo -e "extension=swoole_tracker.so\n\
apm.enable=1\n\
apm.sampling_rate=10" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/swoole_tracker.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole_tracker.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/99-swoole_tracker.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole_tracker.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/99-swoole_tracker.ini
sudo systemctl restart php${DEV_PHP_VER}-fpm
```

## 新版资料

[Swoole Tracker 内存泄漏分析器 v4.0 正式发布](https://mp.weixin.qq.com/s/V9YQKS97H-eWxj923Cqdhw)
https://doc.swoole.com/@memory-tracker/download.html
