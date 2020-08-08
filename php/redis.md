### 通过pecl安装  
```bash
pecl install redis
```

### 源码编译安装  
- 来源地址: https://github.com/phpredis/phpredis  
- 快速开始
    ```bash
    DEV_PHP_VER="7.3"
    DEV_PHPREDIS_VER="5.2.2"
    wget -c -t 5 https://github.com/phpredis/phpredis/archive/${DEV_PHPREDIS_VER}.tar.gz -O phpredis-${DEV_PHPREDIS_VER}.tar.gz \
    && rm -r phpredis-${DEV_PHPREDIS_VER} || true && mkdir -p phpredis-${DEV_PHPREDIS_VER} || true \
    && tar -zxvf phpredis-${DEV_PHPREDIS_VER}.tar.gz -C phpredis-${DEV_PHPREDIS_VER} --strip-components=1 \
    && cd phpredis-${DEV_PHPREDIS_VER} \
    && phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} \
    && make -j$(nproc) && sudo make install
    ```
- 编译配置
    ```bash
    ./configure [--enable-redis-igbinary] [--enable-redis-lzf [--with-liblzf[=DIR]]]
    ```
    - --enable-redis-igbinary 使用igbinary库序列化数据 
    - --enable-redis-lzf 将数据发送到Redis服务器之前压缩数据
    - --with-liblzf[=DIR] 使用预先安装到系统中的lzf库
    - --enable-redis-msgpack 启用msgpack序列化支持 (需要 msgpack-php)

### 扩展部署
```bash
DEV_PHP_VER="7.3"
echo "extension=redis.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/redis.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-redis.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-redis.ini
sudo service php${DEV_PHP_VER}-fpm restart
```