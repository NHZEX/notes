# 检查root权限
if [[ "$EUID" -ne 0 ]]
  then echo "Please run as root"
  exit
fi

# 设置必要常量
DEV_PHP_VER="8.0"
DEV_PHPREDIS_VER="4.2.0"
DEV_SWOOLE_VER="4.2.13"
INSTALL_ROOT_DIR=/home/vagrant/install

# 切换镜像
composer config -g repo.packagist composer https://packagist.laravel-china.org

# 部署环境
mkdir -p ${INSTALL_ROOT_DIR} && cd ${INSTALL_ROOT_DIR} || exit

# 切换默认版本
sudo update-alternatives --set php /usr/bin/php${DEV_PHP_VER} && \
sudo update-alternatives --set php-config /usr/bin/php-config${DEV_PHP_VER} && \
sudo update-alternatives --set phpize /usr/bin/phpize${DEV_PHP_VER} || exit

# 安装gmp
apt-get install libgmp-dev && \
apt-get install php${DEV_PHP_VER}-gmp

# 安装redis
rm -r ${INSTALL_ROOT_DIR}/phpredis
cd ${INSTALL_ROOT_DIR} && \
wget https://github.com/phpredis/phpredis/archive/${DEV_PHPREDIS_VER}.tar.gz -O phpredis-${DEV_PHPREDIS_VER}.tar.gz && \
mkdir -p phpredis && \
tar -zxvf phpredis-${DEV_PHPREDIS_VER}.tar.gz -C phpredis --strip-components=1 && \
cd phpredis && \
phpize && ./configure && \
make && make install || exit

echo "extension=redis.so" > /etc/php/${DEV_PHP_VER}/mods-available/redis.ini && \
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-redis.ini && \
ln -s /etc/php/${DEV_PHP_VER}/mods-available/redis.ini /etc/php/${DEV_PHP_VER}/fpm/conf.d/26-redis.ini

# 安装swoole
rm -r ${INSTALL_ROOT_DIR}/swoole
cd ${INSTALL_ROOT_DIR} && \
wget https://github.com/swoole/swoole-src/archive/v${DEV_SWOOLE_VER}.tar.gz -O swoole-${DEV_SWOOLE_VER}.tar.gz && \
mkdir -p swoole && \
tar -zxvf swoole-${DEV_SWOOLE_VER}.tar.gz -C swoole --strip-components=1 && \
cd swoole && \
phpize && ./configure --enable-sockets --enable-openssl
make && make install || exit

echo "extension=swoole.so" > /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini && \
ln -s /etc/php/${DEV_PHP_VER}/mods-available/swoole.ini /etc/php/${DEV_PHP_VER}/cli/conf.d/26-swoole.ini

# 重启FPM
service php${DEV_PHP_VER}-fpm restart
