### 通过pecl安装  
```bash
pecl install imagick
```

### 底层本体
```shell
DEV_IMAGICK_SRC_VER="7.1.1-34"
wget -c -t 5 https://imagemagick.org/archive/ImageMagick-${DEV_IMAGICK_SRC_VER}.tar.gz -O ImageMagick-${DEV_IMAGICK_SRC_VER}.tar.gz \
&& mkdir -p imagick-${DEV_IMAGICK_SRC_VER} \
&& tar -zxvf ImageMagick-${DEV_IMAGICK_SRC_VER}.tar.gz -C imagick-${DEV_IMAGICK_SRC_VER} --strip-components=1 && cd imagick-${DEV_IMAGICK_SRC_VER} \
&& ./configure \
&& make clean \
&& make -j
sudo make install
sudo ldconfig /usr/local/lib
magick --version
```

### 编译安装
```shell
DEV_PHP_VER="8.0"
DEV_IMAGICK_VER="3.7.0"
wget -c -t 5 https://github.com/Imagick/imagick/archive/refs/tags/${DEV_IMAGICK_VER}.tar.gz -O imagick-${DEV_IMAGICK_VER}.tar.gz \
&& mkdir -p imagick-${DEV_IMAGICK_VER} \
&& tar -zxvf imagick-${DEV_IMAGICK_VER}.tar.gz -C imagick-${DEV_IMAGICK_VER} --strip-components=1 && cd imagick-${DEV_IMAGICK_VER} \
&& phpize${DEV_PHP_VER} --clean && make clean \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} \
&& make -j$(nproc) && sudo make install
```

### 宝塔编译安装
```shell
DEV_PHP_VER="80"
DEV_IMAGICK_VER="3.7.0"
wget -c -t 5 https://github.com/Imagick/imagick/archive/refs/tags/${DEV_IMAGICK_VER}.tar.gz -O imagick-${DEV_IMAGICK_VER}.tar.gz \
&& mkdir -p imagick-${DEV_IMAGICK_VER} \
&& tar -zxvf imagick-${DEV_IMAGICK_VER}.tar.gz -C imagick-${DEV_IMAGICK_VER} --strip-components=1 && cd imagick-${DEV_IMAGICK_VER} \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize --clean \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize \
&& ./configure --with-php-config=/www/server/php/${DEV_PHP_VER}/bin/php-config \
&& make clean \
&& make -j$(nproc) && sudo make install
```

```ini
extension=imagick.so
```