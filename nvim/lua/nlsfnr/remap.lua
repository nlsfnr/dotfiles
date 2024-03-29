vim.g.mapleader = " "
-- Exit vim
vim.keymap.set("n", "QQ", ":q!<CR>")

-- Write buffer or edit new one
vim.keymap.set("n", "<leader>w", ":w!<CR>")
vim.keymap.set("n", "<leader>e", ":e ")

-- Run Makefile
vim.keymap.set("n", "<leader>m", ":!make<CR>")

-- Move by 5 lines or to beginning and end of line
vim.keymap.set("n", "J", "5j")
vim.keymap.set("v", "J", "5j")
vim.keymap.set("n", "K", "5k")
vim.keymap.set("v", "K", "5k")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")

-- Move between windows
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")

-- Split window
vim.keymap.set("n", "<leader>v", "<C-w>v")
vim.keymap.set("n", "<leader>V", "<C-w>s")

-- Show syntax tree
-- vim.keymap.set("n", "<leader>s", ":TSPlaygroundToggle<CR>")

-- Keep yanked content when pasting
vim.keymap.set("v", "p", "\"0p")
vim.keymap.set("v", "y", "\"0y")
vim.keymap.set("n", "y", "\"0y")

-- Yank selection when deleting in visual mode
vim.keymap.set("v", "d", "\"0d")

-- Yank selection into the system clipboard
-- This only worked for me once I ran `apt install xclip xsel`.
vim.keymap.set("n", "<C-y>", "\"+y")
vim.keymap.set("v", "<C-y>", "\"+y")

-- When in block selection mode, adapt changes even when pressing Ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Keep search term in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Quicker find and replace
vim.keymap.set("n", "S", ":%s//g<Left><Left>")

-- Exit to normal mode by smashing j and k
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Move selection up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Restart Lsp and Copilot
vim.keymap.set("n", "<leader>r", ":LspRestart<CR>:!sleep 0.25<CR>:Copilot restart<CR>")

-- Open ~/.plan.md file
vim.keymap.set("n", "<leader>p", ":e ~/.plan.md<CR>")
