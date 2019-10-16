### 源码编译安装  
- 来源地址: https://github.com/swoole/swoole-src/releases
- 快速开始
    ```bash
    DEV_PHP_VER="7.3"
    DEV_SWOOLE_VER="4.4.8"
    wget -c -t 5 https://github.com/swoole/swoole-src/archive/v${DEV_SWOOLE_VER}.tar.gz -O swoole-${DEV_SWOOLE_VER}.tar.gz \
    && mkdir -p swoole-${DEV_SWOOLE_VER} || rm -r swoole-${DEV_SWOOLE_VER} || true \
    && tar -zxvf swoole-${DEV_SWOOLE_VER}.tar.gz -C swoole-${DEV_SWOOLE_VER} --strip-components=1 && cd swoole-${DEV_SWOOLE_VER} \
    && phpize${DEV_PHP_VER} \
    && ./configure --with-php-config=php-config${DEV_PHP_VER} \
      --enable-sockets \
      --enable-openssl \
      --enable-mysqlnd \
      --enable-sockets \
    && make -j$(nproc) && sudo make install
    ```
- 编译配置 [详细信息](https://wiki.swoole.com/wiki/page/437.html)  
    ```bash
    ./configure [--enable-sockets] [--enable-openssl [--with-openssl-dir=DIR]]
    ```
    ##### Debug参数
    - --enable-debug-log  (>=4.2.0) 打开内核DEBUG日志。生产环境不可以启用
    - --enable-trace-log  打开追踪日志，开启此选项后swoole将打印各类细节的调试日志， 仅内核开发时使用
    ##### 基于 4.3.4 的建议配置  
    - --enable-openssl    [--with-openssl-dir=DIR]   使用操作系统提供的libssl.so动态连接库
    - --enable-http2      依赖nghttp2库（依赖以内置）
    - --enable-mysqlnd    依赖mysqlnd模块
    - --enable-sockets    依赖sockets扩展
    - --enable-coroutine-postgresql   [--with-libpq-dir=DIR]    依赖libpq库
    ##### 基于 4.2.13 的建议配置
    - --enable-openssl    [--with-openssl-dir=DIR]   使用操作系统提供的libssl.so动态连接库
    - --enable-http2      [--with-nghttp2-dir=DIR]   依赖nghttp2库
    - --enable-mysqlnd    依赖mysqlnd模块
    - --enable-sockets    依赖sockets扩展
    - --enable-coroutine-postgresql   [--with-libpq-dir=DIR]    依赖libpq库
        
### 部署安装
```bash
DEV_PHP_VER="7.3"
echo "extension=swoole.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-swoole.ini
```