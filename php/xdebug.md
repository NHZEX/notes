### 通过pecl安装  
```bash
pecl install xdebug
```

### 源码编译安装  
- 来源地址: https://github.com/xdebug/xdebug/releases
- 快速开始
    ```bash
    DEV_PHP_VER="7.1"
    DEV_XDEBUG_VER="2.7.2"
    wget -c -t 5 https://github.com/xdebug/xdebug/archive/${DEV_XDEBUG_VER}.tar.gz -O xdebug-${DEV_XDEBUG_VER}.tar.gz \
    && mkdir -p xdebug || rm -r xdebug/* || true \
    && tar -zxvf xdebug-${DEV_XDEBUG_VER}.tar.gz -C xdebug --strip-components=1 && cd xdebug \
    && phpize${DEV_PHP_VER} \
    && ./configure --with-php-config=php-config${DEV_PHP_VER} --enable-xdebug \
    && make -j$(nproc) && sudo make install
    ```

### 扩展部署
```bash
DEV_PHP_VER="7.1"
echo "zend_extension=xdebug.so" > /etc/php/${DEV_PHP_VER}/mods-available/xdebug.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/xdebug.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/25-xdebug.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/xdebug.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/25-xdebug.ini
service php${DEV_PHP_VER}-fpm restart
```