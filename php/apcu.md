### 通过apt安装

```bash
DEV_PHP_VER="7.3"
sudo apt-get install -y php${DEV_PHP_VER}-apcu
sudo systemctl restart php${DEV_PHP_VER}-fpm
```

### 控制面板

https://github.com/krakjoe/apcu/blob/master/apc.php