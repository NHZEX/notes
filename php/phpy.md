### `Ubuntu`源码编译安装
- 来源地址: https://github.com/swoole/phpy/releases
- 编译环境
```bash
# 暂无
```
- 快速开始
```bash
DEV_PHP_VER="8.1"
DEV_PHPY_VER="1.0.11"
wget -c -t 5 https://github.com/swoole/phpy/archive/${DEV_PHPY_VER}.tar.gz -O phpy-${DEV_PHPY_VER}.tar.gz \
&& mkdir -p ./phpy \
&& tar -zxvf phpy-${DEV_PHPY_VER}.tar.gz -C ./phpy --strip-components=1 && cd ./phpy \
&& phpize${DEV_PHP_VER} --clean \
&& phpize${DEV_PHP_VER} \
&& ./configure --with-python-config=$(pyenv prefix 3.11)/bin/python-config \
&& make clean \
&& make -j$(nproc) && sudo make install
```

### `Ubuntu`部署安装
```bash
DEV_PHP_VER="8.1"
echo "extension=phpy.so" | sudo tee /etc/php/${DEV_PHP_VER}/mods-available/phpy.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/phpy.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/99-phpy.ini
sudo ln -s /etc/php/${DEV_PHP_VER}/mods-available/phpy.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/99-phpy.ini
sudo service php${DEV_PHP_VER}-fpm restart
```
