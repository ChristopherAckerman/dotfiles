set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
"source ~/.vimrc


filetype plugin indent  on
syntax on
set spell
set number
set relativenumber
set encoding=utf-8
set clipboard=unnamed
set foldmethod=syntax

let g:tex_flavor='latex'
:autocmd CursorMoved * if line('.') == line('$') | call append('$', '') | endif
set wildmode=longest,list,full

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


let g:plugged_home = '~/.vim/plugged'

call plug#begin(g:plugged_home)
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
call plug#end()

let g:deoplete#enable_at_startup = 1
colorscheme onedark
"""""""""""""""""""""""""" Plug-in settings below
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim

" stuff for coc
set cmdheight=2
set hidden
set updatetime=300
set signcolumn=yes
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" vim-slime stuff
let g:slime_target = "tmux"
let g:slime_python_ipython = 1












