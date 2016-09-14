filetype on
syntax enable
set noswapfile
set autoindent
set cindent
set hidden
set shiftwidth=8
set history=100
set nu
set paste
set nocompatible
set tabstop=8
" spaces
set expandtab
" tabs
set noexpandtab
set backspace=indent,eol,start
set noshowmode " Don't show the current mode (airline.vim takes care of us)
"Set tabstop for sv files
autocmd Filetype *.sv setlocal sts=2 sw=2
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/.ycm_extra_conf.py'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'lervag/vimtex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
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
set tags=./tags,tags;$HOME
map <F3> :ls<CR>:b<Space>
if has('gui_running')
    colorscheme solarized
else
    colorscheme 0x7A69_dark
endif

autocmd FileType c setlocal tabstop=8 softtabstop=8 shiftwidth=8

" Strip trailing whitespace (,ss) {{{
  function! StripWhitespace () " {{{
    let save_cursor = getpos(".")
    let old_query =getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfunction " }}}
  noremap <leader>ss :call StripWhitespace ()<CR>
  " }}}
 
" Plugin Configuration -------------------------------------------------------

" Airline.vim {{{
augroup airline_config
  autocmd!
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_enable_syntastic = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
augroup END
" }}}

" CtrlP.vim {{{
augroup ctrlp_config
  autocmd!
  let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache, to improve CtrlP startup
  let g:ctrlp_lazy_update = 350 " Set delay to prevent extra search
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' } " Use python fuzzy matcher for better performance
  let g:ctrlp_match_window_bottom = 0 " Show at top of window
  let g:ctrlp_max_files = 0 " Set no file limit, we are building a big project
  let g:ctrlp_switch_buffer = 'Et' " Jump to tab AND buffer if already open
  let g:ctrlp_open_new_file = 'r' " Open newly created files in the current window
  let g:ctrlp_open_multiple_files = 'ij' " Open multiple files in hidden buffers, and jump to the first one
augroup END
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler="g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:loaded_syntastic_c_checkpatch_checker = 1
"let g:syntastic_c_checker_checkpatch_location = '/usr/local/bin/checkpatch.pl'
let g:syntastic_c_checkers = ['checkpatch']

" }}}

" YouCompleteMe {{{
" Automatically close the function preview window
let g:ycm_autoclose_preview_window_after_completion = 1

" allow ycm to play nicely with syntastic
let g:ycm_show_diagnostics_ui = 0
" }}}
