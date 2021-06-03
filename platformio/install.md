# CLion + Win

- 安装 Python

> 安装 [Python3.9](https://www.python.org/downloads)

- 安装 PlatformIO Core

> 文档指南: https://docs.platformio.org/en/latest//core/installation.html

- 配置环境变量

> `Path`中添加`%USERPROFILE%\.platformio\penv\Scripts`

- 安装 IDE 插件

> [PlatformIO for Clion](https://plugins.jetbrains.com/plugin/13922-platformio-for-clion)  
> 如果无法识别`PlatformIO`安装路径则手动设置  

- 安装 msys2(mingw-w64)

> 1. 从 https://www.msys2.org 获取安装包  
> 2. 安装成功后执行`MSYS2 MinGW 64-bit`  
> 3. 配置镜像原 https://mirrors.tuna.tsinghua.edu.cn/help/msys2
> 4. 配置系统代理[可选]  
    `export http_proxy=http://127.0.0.1:10901`  
    `export https_proxy=$http_proxy`  
> 4. 依次运行`pacman -Syu`和`pacman -Su`以更新系统基础软件包
> 5. 安装编译工具包  
    `pacman -S mingw-w64-x86_64-toolchain`  
    `pacman -S mingw-w64-x86_64-cmake mingw-w64-x86_64-extra-cmake-modules`  
> 6. 配置 IDE CMake  
> >  配置选项`CMake`>`Toolchain`，添加`MinGw`，`Environment`输入框填入`C:\msys64\mingw64`，等待`IDE`检测成功


# 参考&引用

- [Using MSYS2 installed libraries in CLION](https://stackoverflow.com/questions/43290521/using-msys2-installed-libraries-in-clion)
- [使用 CLion + MSYS2 配置 C 语言编程环境](https://zhuanlan.zhihu.com/p/37908498)
- [配置Proxy server](https://wiki.archlinux.org/title/Proxy_server_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
- [MSYS2 Packages Search](https://packages.msys2.org/queue)
- [Platform.io fails for CLion IDE \(工具链相关错误\)](https://github.com/espressif/arduino-esp32/issues/3748)
- [CLion can’t find Arduino.h Header and other system headers \(工具链相关错误\)](https://community.platformio.org/t/clion-cant-find-arduino-h-header-and-other-system-headers/14961/16)

- [platformio for clion](https://docs.platformio.org/en/latest/integration/ide/clion.html)

- [msys2](https://www.msys2.org/)
- [mingw-w64](http://mingw-w64.org/doku.php/download)