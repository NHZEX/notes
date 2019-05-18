
[换源](Ubuntu18.4LTS换源.md)

```bash
# 设置root密码
sudo passwd root
```

[配置vim](Vim个性化配置.md)
注意配置为给当前用户安装，请提前切换到需要的用户  
```bash

# vim个性化设置(旧)
__vim="
\" 自定义vim 1529080020
\" 开启行号显示
set number
\" 高亮显示当前行/列
set cursorline
\" set cursorcolumn
\" 高亮显示搜索结果
set hlsearch
\" 将制表符扩展为空格
set expandtab
\" 设置编辑时制表符占用空格数
set tabstop=4
\" 设置格式化时制表符占用空格数
set shiftwidth=4
\" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
"
sudo echo "$__vim" >> /etc/vim/vimrc

# 安装lrzsz
sudo apt install lrzsz

# 设置默认cli-php版本
sudo update-alternatives --set php /usr/bin/php7.1
sudo update-alternatives --set php-config /usr/bin/php-config7.1
sudo update-alternatives --set phpize /usr/bin/phpize7.1

# 安装php开发环境
apt install php7.1-dev

# 安装php扩展 redis
pecl install redis
echo "extension=redis.so" > /etc/php/7.1/mods-available/redis.ini
ln -s /etc/php/7.1/mods-available/redis.ini /etc/php/7.1/cli/conf.d/26-redis.ini
ln -s /etc/php/7.1/mods-available/redis.ini /etc/php/7.1/fpm/conf.d/26-redis.ini
service php7.1-fpm restart

# 安装php扩展 swoole
pecl install swoole
echo "extension=swoole.so" > /etc/php/7.1/mods-available/swoole.ini
ln -s /etc/php/7.1/mods-available/swoole.ini /etc/php/7.1/cli/conf.d/26-swoole.ini

# 安装php扩展 gmp
apt install libgmp-dev
apt install php7.1-gmp
```

[安装pm2](pm2安装.md)

[安装frpc](frp安装.md)





