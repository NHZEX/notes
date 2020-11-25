/usr/sbin/sshd -T

### 错误1
```
sshd: no hostkeys available -- exiting.
```
https://wangxianggit.github.io/sshd%20no%20hostkeys%20available
```
root权限下，重新生成密钥：
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
修改密钥权限：
chmod 600 /etc/ssh/ssh_host_dsa_key
chmod 600 /etc/ssh/ssh_host_rsa_key
```

### 错误2
```
Missing privilege separation directory: /run/sshd
```
https://blog.csdn.net/Magic_Ninja/article/details/88068764
```
mkdir /run/sshd
```

### 错误3
```
Access denied for a particular user by PAM account configuration
```
https://unix.stackexchange.com/a/445933
```
Edit /etc/ssh/sshd_config and set

UsePAM no
```

### 自动登录
add key to ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys