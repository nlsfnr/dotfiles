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
set nohlsearch

" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

" Plugins via Plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " Colorscheme
Plug 'Valloric/YouCompleteMe' " Autocomplete
Plug 'mbbill/undotree' " Undotree visualization
Plug 'posva/vim-vue'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Townk/vim-autoclose'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
call plug#end()

" Colorscheme
set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey
" The vimrc might be loaded for the first time, so we do not know if the
" plugins are already installed.
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
set background=dark

lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
EOF

" lua require'lspconfig'.rust.setup{on_attach=require'completion'.on_attach}
" lua require'lspconfig'.python.setup{on_attach=require'completion'.on_attach}

"set completeopt=menuone,noinsert,noselect set shortmess+=c

" Latex live editing
let g:livepreview_previewer = 'okular'
let g:livepreview_engine = 'pdflatex'

" vim-autoclose config
let g:AutoClosePairs = "() {} \" \'"
"
" Convenience remaps
let mapleader = " "

augroup spellcheck
    autocmd!
    " Spellchecking and wrapping
    autocmd FileType tex setlocal wrap textwidth=80 spell
    autocmd FileType markdown setlocal wrap textwidth=80 spell
augroup END

augroup formatting
    autocmd!
    " Format the inner paragraph
    autocmd FileType tex nnoremap <leader>f m0vipgq'0
    autocmd FileType markdown nnoremap <leader>f m0vipgq'0
    " Call cargo fmt
    autocmd FileType rust nnoremap <leader>f :w!<CR>:!cargo fmt<CR><CR>:e!<CR>
augroup END

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>v :vs<CR>
nnoremap <leader>V :sv<CR>
nnoremap <leader>q :q!<CR>
" Operate on current buffer
nnoremap QQ ZQ
nnoremap <leader>w :w!<CR>
nnoremap <leader>e :e<space>
nnoremap <leader>m :w!<CR>:!make<CR>
" Open undotree visaulization
nnoremap <leader>u :UndotreeToggle<CR>
" Fuzzy file finder
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-l> :Files<Cr>
" Vimgrep
nnoremap <C-g> :vimgrep // **/*<Left><Left><Left><Left><Left><Left>
" Center cursor after searches
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
" Faster replacing
nnoremap S :%s//g<Left><Left>
" Jump to end and beginning of line and up and down by 5 rows
nnoremap J 5j
nnoremap K 5k
nnoremap H ^
nnoremap L $
vnoremap J 5j
vnoremap K 5k
vnoremap H ^
vnoremap L $
" Smashing j and k in insert mode will act as ESC
inoremap jk <Esc>
inoremap kj <Esc>
" Yank until the end of the line
nnoremap Y y$
" Move selection upwards and downwards
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" YCM Jumps
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
