require('rose-pine').setup({
    -- Stop background colors from changing when window is not focused
    disable_background = true,
})

function setColors(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFLoat", {bg = "none"})
end

setColors()
