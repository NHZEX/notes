### `Ubuntu`源码编译安装  
- 来源地址: https://github.com/swoole/swoole-src/releases
- 编译环境
```bash
sudo apt install libcurl4-openssl-dev libc-ares-dev libbrotli-dev
```
- 快速开始
```bash
DEV_PHP_VER="8.3"
DEV_SWOOLE_VER="5.1.7"
wget -c -t 5 https://github.com/swoole/swoole-src/archive/v${DEV_SWOOLE_VER}.tar.gz -O swoole-${DEV_SWOOLE_VER}.tar.gz \
&& mkdir -p ./swoole \
&& tar -zxvf swoole-${DEV_SWOOLE_VER}.tar.gz -C ./swoole --strip-components=1 && cd ./swoole \
&& phpize${DEV_PHP_VER} --clean \
&& phpize${DEV_PHP_VER} \
&& ./configure --with-php-config=php-config${DEV_PHP_VER} \
  --enable-openssl \
  --enable-brotli \
  --enable-cares \
  --enable-swoole-curl \
  --enable-swoole-pgsql \
  --enable-swoole-sqlite \
  --enable-sockets \
  --enable-mysqlnd \
&& make clean \
&& make -j$(nproc) && sudo make install
```
- 编译配置 [详细信息](https://wiki.swoole.com/wiki/page/437.html)  
    ```bash
    ./configure [--enable-sockets] [--enable-openssl [--with-openssl-dir=DIR]]
    ```
  - 5.x 新参数
    - --enable-swoole-pgsql
    - --enable-swoole-sqlite
    - --with-pdo-odbc
    - --with-swoole-oracle
  - Debug参数
    - --enable-debug-log  (>=4.2.0) 打开内核DEBUG日志。生产环境不可以启用
    - --enable-trace-log  打开追踪日志，开启此选项后swoole将打印各类细节的调试日志， 仅内核开发时使用 
        
### `Ubuntu`部署安装
```bash
DEV_PHP_VER="8.0"
echo "extension=swoole.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/30-swoole.ini
```

### 宝塔编译安装
```shell
DEV_PHP_VER="80"
DEV_SWOOLE_VER="4.8.12"
wget -c -t 5 https://github.com/swoole/swoole-src/archive/v${DEV_SWOOLE_VER}.tar.gz -O swoole-${DEV_SWOOLE_VER}.tar.gz \
&& mkdir -p swoole-${DEV_SWOOLE_VER} \
&& tar -zxvf swoole-${DEV_SWOOLE_VER}.tar.gz -C swoole-${DEV_SWOOLE_VER} --strip-components=1 && cd swoole-${DEV_SWOOLE_VER} \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize --clean \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize \
&& ./configure --with-php-config=/www/server/php/${DEV_PHP_VER}/bin/php-config \
  --enable-sockets \
  --enable-openssl \
  --enable-mysqlnd \
  --enable-sockets \
  --enable-swoole-json \
  --enable-swoole-curl \
  --enable-cares \
&& make clean \
&& make -j$(nproc) && sudo make install
```