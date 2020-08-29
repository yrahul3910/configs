set nocompatible              " be iMproved, required
set mouse=a
set shell=/bin/bash
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tell-k/vim-autopep8'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'valloric/youcompleteme'
Plugin 'ap/vim-buftabline'
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
set statusline="%{FugitiveStatusline()}"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
let g:ycm_clangd_binary_path = "/Users/ryedida/Downloads/clangd_10.0.0/clangd"
set backspace=indent,eol,start
nnoremap <silent> <S-d> :YcmCompleter GoTo<CR>
nnoremap <silent> <S-t> :YcmCompleter GetType<CR>
nnoremap <silent> <S-?> :YcmCompleter GetDoc<CR>

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


set number autoindent
syntax on
filetype plugin indent on
set tabstop=4 shiftwidth=4 noexpandtab
set noerrorbells
set belloff=all
