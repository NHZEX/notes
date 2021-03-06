## 第三方软件错误：无法解析的密钥格式

`ssh-keygen`可能生成`openssl`的密钥格式，需要转化为`pem`格式

直接转化文件 `ssh-keygen -m PEM -p -f id_rsa`

- https://github.com/agebrock/tunnel-ssh/issues/80
- https://github.com/agebrock/tunnel-ssh/issues/72
- https://stackoverflow.com/questions/54994641/openssh-private-key-to-rsa-private-key
- https://unix.stackexchange.com/questions/84060/convert-openssh-private-key-into-ssh2-private-key
