return {
    { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function() 
        require("catppuccin").setup({
            flavor = "mocha",
            integrations = {
                telescope = {
                    enabled =  true,
                },
            },
        })
        vim.cmd([[colorscheme catppuccin]])
    end,
    },
}
