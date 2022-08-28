
## 安装

https://github.com/tideways/php-xhprof-extension

```bash
DEV_PHP_VER="8.0"
DEV_PHPREDIS_VER="5.3.4"
wget -c -t 5 https://github.com/phpredis/phpredis/archive/${DEV_PHPREDIS_VER}.tar.gz -O phpredis-${DEV_PHPREDIS_VER}.tar.gz \
&& rm -r phpredis-${DEV_PHPREDIS_VER} || true && mkdir -p phpredis-${DEV_PHPREDIS_VER} || true \
&& tar -zxvf phpredis-${DEV_PHPREDIS_VER}.tar.gz -C phpredis-${DEV_PHPREDIS_VER} --strip-components=1 \
&& cd phpredis-${DEV_PHPREDIS_VER} \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} \
&& make -j$(nproc) && sudo make install
```

```bash
DEV_PHP_VER="8.0"
echo "extension=tideways_xhprof.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/tideways_xhprof.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/tideways_xhprof.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/99-tideways_xhprof.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/tideways_xhprof.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/99-tideways_xhprof.ini
sudo service php${DEV_PHP_VER}-fpm restart
```