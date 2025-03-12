return {
  {
    "xapitan/eventer.nvim",
    dev = true,
    config = function()
      require("personal.eventer_config").setup_eventer({})
    end,
  },
}
