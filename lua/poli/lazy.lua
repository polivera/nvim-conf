-- --------------------------------------------------------------------------------------------------------------------
--
-- lazy.nvim plugin manager
--
-- --------------------------------------------------------------------------------------------------------------------

-- This will not mantain order
local plugin_list = {
  require("plugins.cmp").setup(),
  require("plugins.lsp").setup(),
  require("plugins.telescope").setup(),
}

local opts = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Loading plugin path
require("lazy").setup(plugin_list, opts)
