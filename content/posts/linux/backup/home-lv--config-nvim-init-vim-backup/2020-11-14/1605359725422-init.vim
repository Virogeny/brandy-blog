 
" vim配置文件
"--------------------------
" 开启代码高亮
syntax on

" 开启行号显示
set number

" 启用鼠标
set mouse=a

" tab键的宽度
set tabstop=4

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 行号突出显示 
" 取消可以在单词前加no
set relativenumber

" 正在编辑的一行显示编辑线
set cursorline

" 编辑时文字不会超出编辑区
set wrap

" vim命令模式下tab键提示
set wildmenu

" 高亮搜索内容
set hlsearch

" 正在搜索输入内容便会高亮显示
set incsearch

" 搜索时忽略大小写
set ignorecase

" 搜索时智能识别大小写
set smartcase

" vim与系统剪切板共享
set clipboard=unnamedplus

" 插件安装
" call plug#begin('~/.config/nvim/plugged')

" Plug '插件名或者git路径'获取获取插件
" PlugInstall [name ...] [#threads]	安装插件
" PlugUpdate [name ...] [#threads]	安装或者更新插件
" PlugClean[!]	删除没有列出的插件
" PlugUpgrade	升级 vim-plug
" PlugStatus	检查插件状态
"


" 插件安装结束
" call plug#end()
