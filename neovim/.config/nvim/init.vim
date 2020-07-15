set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

filetype plugin indent  on
syntax on
set spell
set number
set relativenumber
set encoding=utf-8
set clipboard=unnamedplus
set foldmethod=syntax

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
":autocmd CursorMoved * if line('.') == line('$') | call append('$', '') | endif
set wildmode=longest,list,full

map <Esc><Esc> :w<CR>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


let g:plugged_home = '~/.vim/plugged'

call plug#begin(g:plugged_home)
Plug 'lervag/vimtex'
Plug 'vim-airline/vim-airline-themes'
Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'haishanh/night-owl.vim'
"Plug 'vim-latex/vim-latex'
Plug 'gerw/vim-latex-suite'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

let g:deoplete#enable_at_startup = 1
colorscheme onedark
highlight Normal ctermbg=none
highlight NonText ctermbg=none

"""""""""""""""""""""""""" Plug-in settings below
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/vim-slime.vim
