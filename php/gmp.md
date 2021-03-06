### 通过apt安装
```bash
DEV_PHP_VER="7.4"
sudo apt-get install -y libgmp-dev php${DEV_PHP_VER}-gmp
sudo service php${DEV_PHP_VER}-fpm restart
```