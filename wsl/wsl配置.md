### 实例配置（wsl.conf）

https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf

```conf
[interop]
# 设置此项将决定 WSL 是否将 Windows 路径元素添加到 $PATH 环境变量中
appendWindowsPath=false
[automount]
# Windows文件是否添加元数据支持Linux系统权限
options = "metadata"
```