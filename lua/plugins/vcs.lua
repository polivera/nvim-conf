return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.plugins.vcs_config").setup_diffview()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.plugins.vcs_config").setup_gitsigns()
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("configs.plugins.vcs_config").setup_neogit()
    end,
  },
}
