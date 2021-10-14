#收集问题

### PHP is_writable() function always returns false for a writable directory

> 来源：https://stackoverflow.com/questions/29343809/php-is-writable-function-always-returns-false-for-a-writable-directory  
> 问题：`SELinux`导致`is_writable`等相关函数返回`false`的问题

#### 解决方案：
```text
After much head-scratching, it transpired that SELinux was preventing the directory from being written to. I found a good tutorial that explains what's going on. I was able to fix it by running this command:

sudo chcon -R -t httpd_sys_rw_content_t tmp
```