### 关于pecl
pecl 默认情况下无法管理多个php版本下的编译安装库，未找到解决方法。  
- [相关链接1](https://stackoverflow.com/questions/40419718/how-to-install-php-extension-using-pecl-for-specific-php-version-when-several-p/48352487)  
- [相关链接2](https://stackoverflow.com/questions/7658784/multiple-php-installs-with-separate-pear)  

### gmp
- 通过apt安装
    ```bash
    DEV_PHP_VER="7.2"
    sudo apt-get install libgmp-dev
    sudo apt-get install php${DEV_PHP_VER}-gmp
    service php${DEV_PHP_VER}-fpm restart
    ```

### redis
- 通过pecl安装  
    ```pecl install redis```
- 源码编译安装  
    - 来源地址: https://github.com/phpredis/phpredis  
    - 快速开始
        ```bash
        DEV_PHPREDIS_VER="4.3.0"
        wget https://github.com/phpredis/phpredis/archive/${DEV_PHPREDIS_VER}.tar.gz -O phpredis-${DEV_PHPREDIS_VER}.tar.gz
        rm -r phpredis/* || mkdir -p phpredis
        tar -zxvf phpredis-${DEV_PHPREDIS_VER}.tar.gz -C phpredis --strip-components=1
        cd phpredis && phpize
        ./configure && make 
        make install
        ```
    - 编译配置
        ```bash
        ./configure [--enable-redis-igbinary] [--enable-redis-lzf [--with-liblzf[=DIR]]]
        ```
        - --enable-redis-igbinary 使用igbinary库序列化数据 
        - --enable-redis-lzf 将数据发送到Redis服务器之前压缩数据
        - --with-liblzf[=DIR] 使用预先安装到系统中的lzf库
- 部署安装
```bash
DEV_PHP_VER="7.2"
echo "extension=redis.so" > /etc/php/${DEV_PHP_VER}/mods-available/redis.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-redis.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-redis.ini
service php${DEV_PHP_VER}-fpm restart
```

### event
- 通过pecl安装  
    ```pecl install event```
- 源码编译安装  
    - 来源地址1: https://pecl.php.net/package/event
    - 来源地址2: https://bitbucket.org/osmanov/pecl-event/src/master/
    - 快速开始
        ```bash
        apt install libevent-dev
        DEV_EVENT_VER="2.4.2"
        url="https://bitbucket.org/osmanov/pecl-event/get/${DEV_EVENT_VER}.tar.bz2"
        filename=$(curl -sI  ${url} | grep -o -E 'filename=.*$' | tr -d '\r\n' | sed -e 's/filename=//')
        wget -c -t 5 ${url} -O event-${DEV_EVENT_VER}.tar.bz2
        tar jxvf event-${DEV_EVENT_VER}.tar.bz2
        cd $(echo ${filename} | sed 's/.tar.bz2//g')
        phpize && ./configure
        make && make install
        ```
- 部署安装
```bash
DEV_PHP_VER="7.2"
echo "extension=event.so" > /etc/php/${DEV_PHP_VER}/mods-available/event.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/event.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-event.ini
```

### swoole
- 源码编译安装  
    - 来源地址: https://github.com/swoole/swoole-src/releases
    - 快速开始
        ```bash
        DEV_SWOOLE_VER="4.3.1"
        wget -c -t 5 https://github.com/swoole/swoole-src/archive/v${DEV_SWOOLE_VER}.tar.gz -O swoole-${DEV_SWOOLE_VER}.tar.gz
        rm -r swoole/* || mkdir -p swoole
        tar -zxvf swoole-${DEV_SWOOLE_VER}.tar.gz -C swoole --strip-components=1
        cd swoole && phpize 
        ./configure --enable-sockets --enable-openssl
        make && make install
        ```
    - 编译配置 [详细信息](https://wiki.swoole.com/wiki/page/437.html)  
        ```bash
        ./configure [--enable-sockets] [--enable-openssl [--with-openssl-dir=DIR]]
        ```
        以下是建议配置，推荐基于 4.2.12
        --enable-sockets    依赖sockets扩展
        --enable-openssl    [--with-openssl-dir=DIR]   使用操作系统提供的libssl.so动态连接库
        --enable-http2      [--with-nghttp2-dir=DIR]   依赖nghttp2库
        --enable-mysqlnd    依赖mysqlnd模块
        --enable-coroutine-postgresql   [--with-libpq-dir=DIR]    依赖libpq库
        补充 4.3.0 开始无需nghttp2库即可开启http2支持
        
- 部署安装
```bash
DEV_PHP_VER="7.2"
echo "extension=swoole.so" > /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-swoole.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-swoole.ini
service php${DEV_PHP_VER}-fpm restart
```
