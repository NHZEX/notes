### 环境依赖

```
apt install -y zlib1g-dev
```

### 源码编译安装  

- 来源地址: https://github.com/viest/php-ext-xlswriter  

```bash
DEV_PHP_VER="8.1"
DEV_XLSWRITER_VER="v1.5.8"
mkdir -p php-ext-excel-export && cd php-ext-excel-export \
&& git clone https://github.com/viest/php-ext-xlswriter . || git fetch origin master:master --tags \
&& git checkout ${DEV_XLSWRITER_VER} \
&& git submodule update --init \
&& phpize${DEV_PHP_VER} --clean && (make clean || true ) \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} --enable-reader \
&& make -j$(nproc) && sudo make install
```

### PECL安装

- 来源地址: https://github.com/viest/php-ext-xlswriter  

```bash
pecl install xlswriter
```

### 扩展部署

```bash
DEV_XLSWRITER_VER="v1.5.8"
mkdir -p php-ext-excel-export && cd php-ext-excel-export \
&& git clone https://github.com/viest/php-ext-xlswriter . || git fetch origin master:master --tags \
&& git checkout ${DEV_XLSWRITER_VER} \
&& git submodule update --init
DEV_PHP_VER="8.1"
phpize${DEV_PHP_VER} --clean \
&& phpize${DEV_PHP_VER} && ./configure --with-php-config=php-config${DEV_PHP_VER} --enable-reader \
&& make clean && make -j$(nproc) && sudo make install

DEV_PHP_VER="8.1"
echo "extension=xlswriter.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/xlswriter.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/xlswriter.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/20-xlswriter.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/xlswriter.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/20-xlswriter.ini
sudo service php${DEV_PHP_VER}-fpm restart
```

### 宝塔编译安装
```shell
DEV_PHP_VER="81"
DEV_XLSWRITER_VER="v1.5.8"
mkdir -p php-ext-excel-export && cd php-ext-excel-export \
&& rm -rf php-ext-excel-export \
&& git clone https://github.com/viest/php-ext-xlswriter . || git fetch \
&& git checkout ${DEV_XLSWRITER_VER} \
&& git submodule update --init \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize --clean \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize && ./configure --with-php-config=/www/server/php/${DEV_PHP_VER}/bin/php-config --enable-reader \
&& make clean && make -j$(nproc) && sudo make install
```

### pecl源码安装
```shell
DEV_PHP_VER="81"
DEV_XLSWRITER_VER="1.5.8"
wget -t 5 https://pecl.php.net/get/xlswriter-${DEV_XLSWRITER_VER}.tgz -O xlswriter-${DEV_XLSWRITER_VER}.tgz \
&& mkdir -p ./xlswriter \
&& tar -zxvf xlswriter-${DEV_XLSWRITER_VER}.tgz -C ./xlswriter --strip-components=1 && cd ./xlswriter \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize --clean \
&& /www/server/php/${DEV_PHP_VER}/bin/phpize && ./configure --with-php-config=/www/server/php/${DEV_PHP_VER}/bin/php-config --enable-reader \
&& make clean && make -j$(nproc) && sudo make install
```

### 打包源码
```shell
git clone https://github.com/viest/php-ext-xlswriter
cd php-ext-xlswriter
git fetch origin master:master --tags
git checkout "v1.5.8"
git submodule update --init
git archive --format=zip --worktree-attributes --output="./php-ext-xlswriter_v1.5.8.zip" HEAD .
```