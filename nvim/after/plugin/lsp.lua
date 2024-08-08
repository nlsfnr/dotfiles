local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

vim.filetype.add({
    extension = {
        j2 = "html",
    },
})

lsp.on_attach(function(client, bufnr)
    if vim.api.nvim_buf_get_name(bufnr) == '/home/nf/.plan.md' then
      client.stop()
      return
    end

    lsp.default_keymaps({buffer = bufnr})

    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next, opts)

    if vim.bo.filetype == "python" then
        -- Add newline containing breakpoint() under current line
        vim.keymap.set("n", "<leader>d", function()
            local indent = vim.fn.indent(".")
            local line = string.rep(" ", indent) .. "breakpoint()"
            vim.fn.append(".", line)
        end, opts)
    end

    if vim.bo.filetype == "tex" or vim.bo.filetype == "markdown" then
        vim.keymap.set("n", "<leader>d", "m_vipgq'_")
    end
end)

cmp.setup({
    mapping = {
        --
        ['<C-j>'] = cmp_action.luasnip_supertab(),
        ['<C-k>'] = cmp_action.luasnip_shift_supertab(),
    }
})

lsp.setup()

-- Enable inline messages from the LSP
vim.diagnostic.config({
    virtual_text = true
})
