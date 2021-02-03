syntax on
filetype plugin on

" Better defaults
set hidden
set noerrorbells
set smartindent
set number relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8

" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType vue setlocal shiftwidth=2 tabstop=2

" Plugins via Plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " Colorscheme
Plug 'Valloric/YouCompleteMe' " Autocomplete
Plug 'mbbill/undotree' " Undotree visualization
Plug 'posva/vim-vue'
call plug#end()

" Colorscheme
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme gruvbox
set background=dark

" Convenience remaps
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" Operate on current buffer
nnoremap <leader>w :w!<CR>
nnoremap <leader>e :e 
nnoremap <leader>qq :q!<CR>
" Open undotree visaulization
nnoremap <leader>u :UndotreeToggle<CR>
" Center cursor after searches
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
" Jump to end and beginning of line and up and down the window
nnoremap J 5j
nnoremap K 5k
nnoremap H ^
nnoremap L $
vnoremap J 5j
vnoremap K 5k
vnoremap H ^
vnoremap L $
" Smashing j and k will act as ESC
inoremap jk <Esc>
inoremap kj <Esc>
" Move selection upwards and downwards
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" YCM Jumps
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>

