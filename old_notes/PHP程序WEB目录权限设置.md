```bash
chmod 755 $(find /www/wwwroot -type d)  
chmod 644 $(find /www/wwwroot -type f)  

### 解决超长参数问题
find /www/wwwroot -type f -print0 | xargs -0 chmod 0664  
find /www/wwwroot -type d -print0 | xargs -0 chmod 0755  

chmod -c 755 $(find /www/wwwroot -type d) && chmod -c 644 $(find /www/wwwroot -type f)
chown -R www:www .

### 自动使用当前目录
find `pwd` -type f -print0 | xargs -0 chmod 0664 && find `pwd` -type d -print0 | xargs -0 chmod 0755
find $PWD -type f -print0 | xargs -0 chmod 0664 && find $PWD -type d -print0 | xargs -0 chmod 0755

```
