-- --------------------------------------------------------------------------------------------------------------------
-- lazy.nvim plugin manager
-- --------------------------------------------------------------------------------------------------------------------

-- This will not mantain order
local plugin_list = {
	require("plugins.telescope"),
	require("plugins.cmp"),
	require("plugins.lsp"),
	require("plugins.treesitter"),
	require("plugins.catppuccin"),
	require("plugins.lualine"),
	require("plugins.gitsigns"),
	require("plugins.neotree"),
	require("plugins.fidget"),
	-- Custom plugins
	require("plugins.local"),
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
