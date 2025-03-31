return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("configs.plugins.catppuccin_config").setup_plugin()
    end,
  },
}
