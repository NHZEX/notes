## 自动化配置
[来源](https://zhuanlan.zhihu.com/p/28795673)
[来源](https://github.com/Wangzhike/VimConfigScript)

目前脚本自动安装的插件有：
- [自动补全插件YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
- [语法检查插件syntastic](https://github.com/vim-syntastic/syntastic)
- [代码折叠插件SimpylFold](https://github.com/tmhedberg/SimpylFold)
- [显示文件树/文件目录插件NERDTree](https://github.com/scrooloose/nerdtree)
- [状态栏增强插件vim-airline](https://github.com/vim-airline/vim-airline)
- [查看显示代码文件中的宏，函数，变量定义等的插件taglist](http://www.vim.org/scripts/script.php?script_id=273)

快速开始
```bash
git clone https://github.com/Wangzhike/VimConfigScript.git
cd VimConfigScript
./configVim.sh -all
```

命令说明  
- 安装所有插件```./configVim.sh -all```或```./configVim.sh```  
- 安装指定插件```./configVim.sh -s [Plugin1] [Plugin2] ... [PluginN]```
- 安装除外插件```./configVim.sh -v [Plugin1] [Plugin2] ... [PluginN]```

内置插件名称
```text
YouCompleteMe
Syntasitic
SimplyFold
NERDTree
AirLine
```

## 原自定义配置
```bash
sudo echo "
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
" >> /etc/vim/vimrc
```
