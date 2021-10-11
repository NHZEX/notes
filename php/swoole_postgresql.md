### 源码编译安装
- 来源地址: https://github.com/swoole/ext-postgresql
- 快速开始
```bash
DEV_PHP_VER="7.4"
DEV_SWOOLE_PG_VER="f5eda17f89d160d0a89ac7c5db4636bdaefd48e6" # swoole-4.7.1
wget -c -t 5 https://github.com/swoole/ext-postgresql/archive/${DEV_SWOOLE_PG_VER}.tar.gz -O swoole_pg_${DEV_SWOOLE_PG_VER}.tar.gz \
&& rm -r swoole_postgresql || true && mkdir -p swoole_postgresql || true \
&& tar -zxvf swoole_pg_${DEV_SWOOLE_PG_VER}.tar.gz -C swoole_postgresql --strip-components=1 \
&& cd swoole_postgresql \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} \
&& make -j$(nproc) && sudo make install

echo "extension=swoole_postgresql.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/swoole_postgresql.ini
sudo phpenmod -v ${DEV_PHP_VER} swoole_postgresql
```