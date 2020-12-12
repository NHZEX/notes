### 源码编译安装  
- 来源地址: https://github.com/kjdev/php-ext-lz4  
- 快速开始:
```shell script
DEV_PHP_VER="7.4"
mkdir lz4
tar -xvf lz4-0.3.6.tar.gz -C lz4 --strip-components=1
cd lz4
phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER}
make -j$(nproc) && sudo make install

echo "extension=lzf.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/25-lzf.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/25-lzf.ini
sudo service php${DEV_PHP_VER}-fpm restart
```