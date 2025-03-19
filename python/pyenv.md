## 安装

- [pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv)

```bash
# 自动安装
curl -fsSL https://pyenv.run | bash

# 配置bash：~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc
eval 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# rstart shell
exec "$SHELL"

# 安装编译依赖
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt update
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# 安装 pythone
pyenv install 3.11
pyenv install 3.11-dev
pyenv global 3.11
```

## 记录

```bash
# 获取当前版本路径
pyenv which python

# 获取指定版本（1）
pyenv prefix 3.11

# 获取指定版本（2）
PYENV_VERSION=3.11 pyenv which python
```

## 资料

### [使用 Pyenv 管理多個 Python 版本](https://blog.codylab.com/python-pyenv-management/)

安裝其它版本的 Python
查看可供安裝的 python 版本

```bash
pyenv install -l

# 3.4.0
# 3.4.1
# 3.4-dev
```

如果想要裝 3.4.1 的話，就使用pyenv install

```bash
pyenv install 3.4.1
```

查看已安裝的 Python 版本
先用pyenv versions 查看目前已安裝 Python 的版本

```bash
pyenv versions
# * system
#  3.4.1
#  顯示目前預設是 system, 而可以切換到 3.4.1 的版本
```

```bash
pyenv global <version> # set global python version
pyenv local <version>  #在當前目錄創建一個.python-version，以後進入這個目錄自動切換爲該版本
pyenv shell <version>  #在當前shell的session裏啓用某個Python版本，優先級高於global,local
```
查看目前使用的 python 版本
pyenv 可以設定三種 scope，分別是 global, local 和 shell。shell 是只有當次登入 shell 有效，而 global 則是有修改系統 python 版本的效果, 我最常用的是 local，會更改當下目錄使用的 python 版本。

```bash
pyenv global
pyenv local
pyenv shell
```
使用 pyenv-virtualenv
新增一個 virtualenv uber

```bash
pyenv virtualenv 3.4.1 uber
```
此時會發現多了一個 python

```bash
pyenv versions

# system
# 3.4.1
# * uber (set by /home/cwliu/Downloads/uber/.python-version)
```

在此目錄使用該 virtualenv

```bash
pyenv local uber
```