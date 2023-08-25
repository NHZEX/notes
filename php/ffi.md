### 宝塔安装

```bash
wget https://www.php.net/distributions/php-8.0.26.tar.bz2
tar -xvf php-8.0.26.tar.bz2
cd php-8.0.26/ext/ffi

/www/server/php/80/bin/phpize
./configure --with-php-config=/www/server/php/80/bin/php-config
make
sudo make install
```