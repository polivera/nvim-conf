-- Configure LSP
-- This code is (mostly) copy from neovim kickstart
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Define servers configuration to be used in the lsp
local function setup_lspconfig() end

function setup_mason() end

return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lsp_config = require("configs.plugins.lsp_config")
      lsp_config.setup_lsp()
      lsp_config.setup_mason()
    end,
  },
}
