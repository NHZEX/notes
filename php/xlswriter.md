### 环境依赖

```
apt install -y zlib1g-dev
```

### 源码编译安装  

- 来源地址: https://github.com/viest/php-ext-xlswriter  

```bash
DEV_PHP_VER="7.3"
DEV_XLSWRITER_VER="1.3.4.1"
mkdir -p php-ext-excel-export && cd php-ext-excel-export \
&& git clone https://github.com/viest/php-ext-excel-export . || git fetch \
&& git checkout ${DEV_XLSWRITER_VER} \
&& git submodule update --init \
&& phpize${DEV_PHP_VER} --clean \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} --enable-reader \
&& make -j$(nproc) && sudo make install
```

### PECL安装

- 来源地址: https://github.com/viest/php-ext-xlswriter  

```bash
pecl install xlswriter
```

### 扩展部署

```bash
DEV_PHP_VER="7.3"
echo "extension=xlswriter.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/redis.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-redis.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-redis.ini
sudo service php${DEV_PHP_VER}-fpm restart
```
