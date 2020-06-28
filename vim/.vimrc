execute pathogen#infect()

filetype plugin indent  on
syntax on
set number
set relativenumber
set encoding=utf-8
set clipboard=unnamed
colorscheme firewatch

let g:tex_flavor='latex'
:autocmd CursorMoved * if line('.') == line('$') | call append('$', '') | endif
set wildmode=longest,list,full

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>



