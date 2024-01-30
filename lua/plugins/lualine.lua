-- --------------------------------------------------------------------------------------------------------------------
-- Lualine
-- --------------------------------------------------------------------------------------------------------------------

local function get_file_path()
	local result = vim.fn.expand("%:.")
	-- TODO: Add some indication that the buffer is not saved
	--       note: command ls for example gives this information
	return result
end

local lualine_config = function(_, _)
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { get_file_path } },
			lualine_x = { "encoding", "fileformat" },
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "location" },
			lualine_z = {},
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					symbols = {
						modified = " ●", -- Text to show when the buffer is modified
						alternate_file = "", -- Text to show to identify the alternate file
						directory = "", -- Text to show when the buffer is a directory
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "tabs" },
		},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = lualine_config,
}
