### 通过pecl安装  
```bash
pecl install redis
```

### 源码编译安装  
- 来源地址: https://github.com/phpredis/phpredis  
- 快速开始
    ```bash
    DEV_PHP_VER="7.2"
    DEV_PHPREDIS_VER="4.3.0"
    wget https://github.com/phpredis/phpredis/archive/${DEV_PHPREDIS_VER}.tar.gz -O phpredis-${DEV_PHPREDIS_VER}.tar.gz
    rm -r phpredis/* || mkdir -p phpredis
    tar -zxvf phpredis-${DEV_PHPREDIS_VER}.tar.gz -C phpredis --strip-components=1 && cd phpredis
    phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER}
    make && make install
    ```
- 编译配置
    ```bash
    ./configure [--enable-redis-igbinary] [--enable-redis-lzf [--with-liblzf[=DIR]]]
    ```
    - --enable-redis-igbinary 使用igbinary库序列化数据 
    - --enable-redis-lzf 将数据发送到Redis服务器之前压缩数据
    - --with-liblzf[=DIR] 使用预先安装到系统中的lzf库

### 扩展部署
```bash
DEV_PHP_VER="7.2"
echo "extension=redis.so" > /etc/php/${DEV_PHP_VER}/mods-available/redis.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-redis.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-redis.ini
service php${DEV_PHP_VER}-fpm restart
```