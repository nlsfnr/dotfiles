require("tabset").setup({
    defaults = {
        tabwidth = 4,
        expandtab = true
    },
    languages = {
        {
            filetypes = {
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "json",
                "yaml",
                "html",
                "css",
            },
            config = {
                tabwidth = 2
            }
        }
    }
})
