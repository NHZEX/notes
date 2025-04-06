## 建立PHP软链接

```bash
ln -s /www/server/php/80/bin/php /usr/local/bin/php80
ln -s /www/server/php/81/bin/php /usr/local/bin/php81
ln -s /www/server/php/82/bin/php /usr/local/bin/php82
```

##  修复错误`undefined symbol: EVP_md2, version OPENSSL_1_1_0`

```bash
cd /root
wget https://download.bt.cn/src/openssl-1.1.1o.tar.gz -T 20 
tar -zxf openssl-1.1.1o.tar.gz  
cd openssl-1.1.1o  
./config --prefix=/usr/local/openssl111 --openssldir=/usr/local/openssl111 enable-md2 enable-rc5 sctp zlib-dynamic shared -fPIC 
make install 
echo "/usr/local/openssl111/lib" >> /etc/ld.so.conf.d/zopenssl111.conf 
ldconfig
```

可尝试是否能升级为更高版本 - 1.1.1w  
[OpenSSL 1.1.1 Series Release Notes | OpenSSL Library](https://openssl-library.org/news/openssl-1.1.1-notes/index.html)
