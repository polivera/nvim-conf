return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.plugins.linting_config").setup_plugin()
    end,
  },
}
