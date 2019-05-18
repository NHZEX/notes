composer config -g repo.packagist composer https://packagist.phpcomposer.com
npm config set registry https://registry.npm.taobao.org
npm install -g bower

apt install php7.1-dev

sudo update-alternatives --set php /usr/bin/php7.1


###libjemalloc

apt-get install libjemalloc-dev
sudo ldconfig

wget  https://github.com/jemalloc/jemalloc/releases/download/5.1.0/jemalloc-5.1.0.tar.bz2
bzip2 -d jemalloc-5.1.0.tar.bz2
tar xvf jemalloc-5.1.0.tar
cd jemalloc-5.1.0
./configure  -prefix=/usr/local/jemalloc --libdir=/usr/local/lib
make  && make install
echo /usr/local/lib >> /etc/ld.so.conf
ldconfig


### hiredis
# 在redis的发行包中的deps目录中就包含hiredis的源码，手动编译安装，或者自行下载一份
wget  https://github.com/redis/hiredis/archive/v0.13.3.tar.gz
mv v0.13.3.tar.gz hiredis.v0.13.3.tar.gz
tar zxvf  hiredis.v0.13.3.tar.gz
cd hiredis-0.13.3
make && make install
sudo ldconfig

###swoole

直接安装 pecl install swoole

编译安装
wget https://github.com/swoole/swoole-src/archive/v2.2.0.tar.gz
wget https://github.com/swoole/swoole-src/archive/v4.0.0.tar.gz
wget https://github.com/swoole/swoole-src/archive/v4.0.1.tar.gz

tar zxvf v4.0.1.tar.gz
cd swoole-src-4.0.1
make distclean && make clean
phpize
./configure --enable-openssl --enable-async-redis --enable-mysqlnd --enable-coroutine-postgresql
make -j 2 && sudo make install

echo "extension=swoole.so" > /etc/php/7.1/mods-available/swoole.ini
ln -s /etc/php/7.1/mods-available/swoole.ini /etc/php/7.1/cli/conf.d/swoole.ini

###igbinary

pecl upgrade igbinary
service php7.1-fpm restart
