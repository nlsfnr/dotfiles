local function setn(left, right) vim.keymap.set("n", left, right) end
local function setv(left, right) vim.keymap.set("v", left, right) end
local function seti(left, right) vim.keymap.set("i", left, right) end

vim.g.mapleader = " "

-- Exit vim
setn("QQ", ":q!<CR>")

-- Write buffer or edit new one
setn("<leader>w", ":w!<CR>")
setn("<leader>e", ":e ")
setn("<leader>m", ":!make<CR>")

-- Move by 5 lines or to beginning and end of line
setn("J", "5j")
setv("J", "5j")
setn("K", "5k")
setv("K", "5k")
setn("H", "^")
setv("H", "^")
setn("L", "$")
setv("L", "$")

-- Move between windows
setn("<leader>j", "<C-w>j")
setn("<leader>k", "<C-w>k")
setn("<leader>h", "<C-w>h")
setn("<leader>l", "<C-w>l")

-- Split window
setn("<leader>v", "<C-w>v")
setn("<leader>V", "<C-w>s")

-- Keep yanked content when pasting
setv("p", "\"0p")
setv("y", "\"0y")
setn("y", "\"0y")

-- Yank selection when deleting in visual mode
setv("d", "\"0d")

-- Yank selection into the system clipboard
-- This only worked for me once I ran `apt install xclip xsel`.
setn("<C-y>", "\"+y")
setv("<C-y>", "\"+y")

-- When in block selection mode, adapt changes even when pressing Ctrl+c
seti("<C-c>", "<Esc>")

-- Keep search term in the middle of the screen
setn("n", "nzzzv")
setn("N", "Nzzzv")

-- Quicker find and replace
setn("S", ":%s//g<Left><Left>")

-- Exit to normal mode by smashing j and k
seti("jk", "<ESC>")
seti("kj", "<ESC>")
seti("jj", "j")
seti("kk", "k")

-- Move selection up and down
setv("<C-j>", ":m '>+1<CR>gv=gv")
setv("<C-k>", ":m '<-2<CR>gv=gv")

-- Restart Lsp and Copilot
setn("<leader>r", ":LspRestart<CR>:!sleep 0.25<CR>:Copilot restart<CR>")

-- Open ~/.plan.md file
setn("<leader>p", ":e ~/.plan.md<CR>")


-- Additional, plugin-specific remaps can be found in the after/ directory.
