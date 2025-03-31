return {
  {
    "xapitan/eventer.nvim",
    dev = true,
    config = function()
      require("configs.plugins.eventer_config").setup_eventer({})
    end,
  },
}
