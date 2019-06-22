### 通过pecl安装  
```bash
pecl install event
```

### 源码编译安装  
- 来源地址1: https://pecl.php.net/package/event
- 来源地址2: https://bitbucket.org/osmanov/pecl-event/src/master/
- 快速开始
    ```bash
    apt install libevent-dev
    DEV_PHP_VER="7.2"
    DEV_EVENT_VER="2.4.2"
    url="https://bitbucket.org/osmanov/pecl-event/get/${DEV_EVENT_VER}.tar.bz2"
    filename=$(curl -sI  ${url} | grep -o -E 'filename=.*$' | tr -d '\r\n' | sed -e 's/filename=//')
    wget -c -t 5 ${url} -O event-${DEV_EVENT_VER}.tar.bz2
    tar jxvf event-${DEV_EVENT_VER}.tar.bz2
    cd $(echo ${filename} | sed 's/.tar.bz2//g')
    phpize && ./configure
    make && make install
    ```

### 部署安装
```bash
DEV_PHP_VER="7.2"
echo "extension=event.so" > /etc/php/${DEV_PHP_VER}/mods-available/event.ini
ln -s /etc/php/${DEV_PHP_VER}/mods-available/event.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-event.ini
```