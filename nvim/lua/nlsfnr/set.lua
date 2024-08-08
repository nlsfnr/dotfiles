local o = vim.opt

o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.wrap = false

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.termguicolors = true

o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")

o.updatetime = 50
o.colorcolumn = "100"


-- Wrap lines in markdown files
vim.cmd [[
    autocmd FileType markdown setlocal wrap
    nnoremap j gj
    nnoremap k gk
]]

-- Set tabs for Makefiles
vim.cmd [[
    autocmd BufNewFile,BufRead Makefile setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
    autocmd BufNewFile,BufRead *.mk setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
]]
