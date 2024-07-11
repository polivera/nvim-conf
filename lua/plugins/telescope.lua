-- --------------------------------------------------------------------------------------------------------------------
-- Telescope configuration
-- --------------------------------------------------------------------------------------------------------------------

-- Set the global ignore patterns
local ignore_patterns = {
	"node_modules",
}

local extensions = {
	fzf = function(_)
		return {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		}
	end,

	["ui-select"] = function(_)
		return require("telescope.themes").get_dropdown({})
	end,
}

local telescope_plugin_mappings = function()
	local ta = require("telescope.actions")

	return {
		n = {
			["<C-n>"] = ta.cycle_history_next,
			["<C-p>"] = ta.cycle_history_prev,
			["<C-j>"] = ta.move_selection_next,
			["<C-k>"] = ta.move_selection_previous,
			["<C-c>"] = ta.close,
			["<CR>"] = ta.select_default,
			["<C-x>"] = ta.select_horizontal,
			["<C-v>"] = ta.select_vertical,
			["<C-t>"] = ta.select_tab,
		},
		i = {
			["<C-n>"] = ta.cycle_history_next,
			["<C-p>"] = ta.cycle_history_prev,
			["<C-j>"] = ta.move_selection_next,
			["<C-k>"] = ta.move_selection_previous,
			["<C-c>"] = ta.close,
			["<CR>"] = ta.select_default,
			["<C-x>"] = ta.select_horizontal,
			["<C-v>"] = ta.select_vertical,
			["<C-t>"] = ta.select_tab,
		},
	}
end

local telescope_config = function()
	local telescope = require("telescope")

	local telescope_settings = {
		-- Base configuration
		defaults = {
			mappings = telescope_plugin_mappings(),
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			initial_mode = "insert",
			set_env = { ["COLORTERM"] = "truecolor" },
			-- Laout configuration ----------------------------------
			prompt_prefix = "   ",
			selection_caret = "> ",
			entry_prefix = " ",
			layout_strategy = "horizontal",
			path_display = { "truncate" },
			color_devicons = true,
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
				prompt_position = "top",
			},
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			-- Other --------------------------------------------
			file_ignore_patterns = ignore_patterns,
		},
		-- Pickers configurations
		pickers = {
			find_files = {
				hidden = false,
			},
		},
		-- extensions
		extensions = {},
	}

	for ext_name, ext_config in pairs(extensions) do
		telescope_settings.extensions[ext_name] = ext_config()
	end

	telescope.setup(telescope_settings)

	for ext_name, _ in pairs(extensions) do
		local ok, _ = pcall(require, ext_name)
		if ok then
			telescope.load_extension(ext_name)
		end
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = telescope_config,
	},
}
