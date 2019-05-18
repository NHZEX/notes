# 安装yar
```bash
# 安装yar
pecl install yar

# 导入引用
echo "extension=yar.so" > /etc/php/7.1/mods-available/yar.ini
ln -s /etc/php/7.1/mods-available/yar.ini /etc/php/7.1/cli/conf.d/30-yar.ini
ln -s /etc/php/7.1/mods-available/yar.ini /etc/php/7.1/fpm/conf.d/30-yar.ini
service php7.1-fpm restart

# 安装event
pecl install event

# 错误 configure: error: Cannot find OpenSSL's libraries
# 安装 apt install openssl
# 如果还提示该错误则查找libssl.so所在位置重新连接一下
# find / -name libssl.so
# out: /usr/lib/x86_64-linux-gnu/libssl.so
# ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib

# 导入引用
echo "extension=event.so" > /etc/php/7.1/mods-available/event.ini
ln -s /etc/php/7.1/mods-available/event.ini /etc/php/7.1/cli/conf.d/30-event.ini

```
- 解决编译错误 Please reinstall the libcurl distribution - easy.h should be in <curl-dir>/include/curl/
```bash
# 没遇到过缺失该包 应该不需要该包
apt-get install curl
# 遇到过缺失该包 需要安装
apt-get install libcurl4-gnutls-dev
# libcurl可能被安装在了/usr/include/x86_64-linux-gnu/curl路径
ln -s /usr/include/x86_64-linux-gnu/curl /usr/include/
```
