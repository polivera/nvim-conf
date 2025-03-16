return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.plugins.nvim_tree_config").setup_plugin()
    end,
  },
}
