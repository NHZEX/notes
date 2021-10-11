### 源码编译安装
- 来源地址: https://github.com/hprose/hprose-pecl
- 快速开始
```bash
DEV_PHP_VER="7.4"
DEV_HPROSE_VER="v1.8.0"
wget -c -t 5 https://github.com/hprose/hprose-pecl/archive/${DEV_HPROSE_VER}.tar.gz -O hprose-${DEV_HPROSE_VER}.tar.gz \
&& rm -r hprose || true && mkdir -p hprose || true \
&& tar -zxvf hprose-${DEV_HPROSE_VER}.tar.gz -C hprose --strip-components=1 \
&& cd hprose \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} --enable-hprose=shared \
&& make -j$(nproc) && sudo make install

echo "extension=hprose.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/hprose.ini
sudo phpenmod -v ${DEV_PHP_VER} hprose
```