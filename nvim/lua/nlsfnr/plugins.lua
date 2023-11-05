local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {'nvim-lua/plenary.nvim'}
    },

    -- Colorscheme: Rose Pine
    { 'rose-pine/neovim', name = 'rose-pine' },

    -- Treesitter: Syntax-aware highlighting
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',

    -- Harpoonn: Active set of files
    'theprimeagen/harpoon',

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },

    -- Copilot
    "github/copilot.vim",

    -- Trim trailing whitespace
    "cappyzawa/trim.nvim",
})
