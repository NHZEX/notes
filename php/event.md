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
DEV_PHP_VER="8.1"
DEV_EVENT_VER="3.0.6"
wget -c -t 5 https://bitbucket.org/osmanov/pecl-event/get/${DEV_EVENT_VER}.tar.bz2 -O event-${DEV_EVENT_VER}.tar.bz2 \
&& mkdir -p ./event \
&& tar -jxvf event-${DEV_EVENT_VER}.tar.bz2 -C ./event --strip-components=1 && cd ./event \
&& phpize${DEV_PHP_VER} --clean \
&& phpize${DEV_PHP_VER} \
&& ./configure \
&& make clean \
&& make -j$(nproc) && sudo make install
```

### 部署安装
```bash
DEV_PHP_VER="8.1"
echo "extension=event.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/event.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/event.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-event.ini
```