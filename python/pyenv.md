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
pyenv install 3.10
pyenv global 3.10
```