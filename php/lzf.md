### 源码编译安装  
- 来源地址: https://pecl.php.net/package/lzf  
- 快速开始
    ```bash
    DEV_PHP_VER="7.4"
    mkdir LZF
    tar -xvf LZF-1.6.8.tgz -C LZF --strip-components=1
    cd LZF
    phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER}
    make -j$(nproc) && sudo make install
    ```

### 扩展部署
```bash
DEV_PHP_VER="7.4"
echo "extension=lzf.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/25-lzf.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/lzf.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/25-lzf.ini
sudo service php${DEV_PHP_VER}-fpm restart
```