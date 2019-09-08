### 通过apt安装
```bash
DEV_PHP_VER="7.2"
sudo apt-get install libgmp-dev
sudo apt-get install php${DEV_PHP_VER}-gmp
sudo service php${DEV_PHP_VER}-fpm restart
```