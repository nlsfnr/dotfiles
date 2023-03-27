vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer
    use 'wbthomason/packer.nvim'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Colorscheme: Rose Pine
    use({ 'rose-pine/neovim', as = 'rose-pine' })

    -- Treesitter: Syntax-aware highlighting
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')

    -- Harpoonn: Active set of files
    use('theprimeagen/harpoon')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")

    -- Trim trailing whitespace
    use("cappyzawa/trim.nvim")
end)
