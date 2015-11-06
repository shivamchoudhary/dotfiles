filetype off
syntax enable
set noswapfile
set autoindent
set cindent
set hidden
set shiftwidth=8
set expandtab
set history=100
set nu
set paste
set nocompatible
set tabstop=8
set expandtab
set backspace=indent,eol,start
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/.ycm_extra_conf.py'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'lervag/vimtex'
call vundle#end()
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/*']
filetype plugin indent on
set background=dark
colorscheme solarized
map <F8> :!g++ % && ./a.out <CR>
map <F2> :NERDTreeToggle <CR>
set anti enc=utf-8
set guifont=Source\ Code\ Pro\ 11
set tw=80
set colorcolumn=80
au BufWritePost *.c,*.cpp,*.h,*.py silent! !ctags -R &
map <F3> :ls<CR>:b<Space>
