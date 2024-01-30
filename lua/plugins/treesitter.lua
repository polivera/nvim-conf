-- --------------------------------------------------------------------------------------------------------------------
-- Catppuccin color scheme
-- --------------------------------------------------------------------------------------------------------------------
local treesitter_config = function(_, _)
	local configs = require("nvim-treesitter.configs")
	configs.setup({
		modules = {},
		ensure_installed = {},
		sync_install = false,
		auto_install = true,
		ignore_install = {},
		highlight = {
			enable = true,
			-- This function disable treesitter if the file is bigger than 100 KB
			-- The first parameter is the language (just in case)
			disable = function(_, buf)
				local max_filesize = 30 * 1024 * 1024 -- 30 MB
				local stats_ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if stats_ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = treesitter_config,
}
