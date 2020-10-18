#!/bin/bash

Ell=$(cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
Var=$Ell/.var
mkdir -p $Var

# Install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

want=$Var/vimrc;
[ -f "$want" ] || cat<<'EOF'>$want

set nocompatible              " be iMproved, required
set mouse=a
set shell=/bin/bash
set splitbelow
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

autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
packadd! onedark.vim
colorscheme onedark

set number autoindent
syntax on
filetype plugin indent on
set tabstop=4 shiftwidth=4 noexpandtab
set noerrorbells
set belloff=all

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
EOF

mv $Var/vimrc ~/.vimrc
cd ~/.vim/bundle/youcompleteme/ && python3 install.py
git clone https://github.com/joshdick/onedark.vim.git ~/.vim/pack/onedark/opt/onedark.vim/

if [ ! -d "$HOME/.vim/bundle" ]; then
   git clone https://github.com/VundleVim/Vundle.vim.git \
         ~/.vim/bundle/Vundle.vim
   vim -u .vimrc  +PluginInstall +qall
fi

want=$Var/tmuxrc
[ -f "$want" ] ||  cat<<'EOF'> $want
set -g aggressive-resize on
unbind C-b
set -g prefix C-Space
bind C-Space send-prefix
set -g base-index 1
# start with pane 1
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %
# open new windows in the current path
bind c new-window -c "#{pane_current_path}"
# reload config file
bind r source-file $Tnix/.config/dottmux
unbind p
bind p previous-window
# shorten command delay
set -sg escape-time 1
# don't rename windows automatically
set-option -g allow-rename off
# mouse control (clickable windows, panes, resizable panes)
set -g mouse on
# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
# enable vi mode keys
set-window-option -g mode-keys vi
# set default terminal mode to 256 colors
set -g default-terminal "screen-256color"
bind-key u capture-pane \;\
    save-buffer /tmp/tmux-buffer \;\
    split-window -l 10 "urlview /tmp/tmux-buffer"
bind P paste-buffer
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none
#  modes
setw -g clock-mode-colour colour5
# panes
# statusbar
set -g status-position top
set -g status-justify left
set -g status-bg colour232
set -g status-fg colour137
###set -g status-attr dim
set -g status-left ''
set -g status-right '#{?window_zoomed_flag,🔍,} #[fg=colour255,bold]#H #[fg=colour255,bg=colour19,bold] %b %d #[fg=colour255,bg=colour8,bold] %H:%M '
set -g status-right '#{?window_zoomed_flag,🔍,} #[fg=colour255,bold]#H '
set -g status-right-length 50
set -g status-left-length 20
setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
# messages
# layouts
bind S source-file $Tnix/.config/tmux-session1
setw -g monitor-activity on
set -g visual-activity on
EOF

want=~/.oh-my-zsh/themes/.geoffgarside.zsh-theme
cat <<'EOF'> $want

PROMPT='[%D{%a, %b %d %Y}%@] %{$fg[green]%}%2/%{$reset_color%}$(git_prompt_info) %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
EOF

want=~/.zshrc
cat <<'EOF'> $want

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ryedida/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gcloud=/Users/ryedida/Downloads/google-cloud-sdk/bin/gcloud
alias jupyter=/Users/ryedida/opt/anaconda3/bin/jupyter
EOF

mv $Var/.tmuxrc ~/.tmuxrc
rm -r $Var
