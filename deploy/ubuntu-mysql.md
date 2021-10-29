## apt 安装

```bash
echo "mysql-server mysql-server/root_password password secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password secret" | debconf-set-selections
apt install -y mysql-server

# Configure MySQL 8 Remote Access and Native Pluggable Authentication
cat > /etc/mysql/conf.d/mysqld.cnf << EOF
[mysqld]
bind-address = 0.0.0.0
default_authentication_plugin = mysql_native_password
EOF

# Configure MySQL Password Lifetime
echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure MySQL Remote Access
sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart

export MYSQL_PWD=secret
export MYSQL_MY_PWD=1233123

mysql --user="root" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'secret';"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"

mysql --user="root" -e "CREATE USER 'zxin'@'0.0.0.0' IDENTIFIED WITH caching_sha2_password BY '${MYSQL_MY_PWD}';"
mysql --user="root" -e "CREATE USER 'zxin'@'%' IDENTIFIED WITH caching_sha2_password BY '${MYSQL_MY_PWD}';"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'zxin'@'0.0.0.0' WITH GRANT OPTION;"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'zxin'@'%' WITH GRANT OPTION;"

mysql --user="root" -e "FLUSH PRIVILEGES;"

# mysql --user="root" -e "CREATE DATABASE homestead character set UTF8mb4 collate utf8mb4_bin;"

tee ~/.my.cnf <<EOL
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_bin
EOL

service mysql restart
```

## 资料

- https://dev.mysql.com/doc/refman/8.0/en/create-user.html