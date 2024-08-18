-- Set the global ignore patterns
local ignore_patterns = {
	"node_modules",
	"vendor",
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
}

local telescope = require("telescope")
local ta = require("telescope.actions")

local telescope_settings = {
	-- Base configuration
	defaults = {
		mappings = {
			n = {
				["<C-n>"] = ta.cycle_history_next,
				["<C-p>"] = ta.cycle_history_prev,
				["<C-j>"] = ta.move_selection_next,
				["<C-k>"] = ta.move_selection_previous,
				["<C-c>"] = ta.close,
				["<C-g>"] = ta.close,
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
				["<C-g>"] = ta.close,
				["<CR>"] = ta.select_default,
				["<C-x>"] = ta.select_horizontal,
				["<C-v>"] = ta.select_vertical,
				["<C-t>"] = ta.select_tab,
			},
		},
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
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		generic_sorter = require("telescope.sorters").get_fzy_sorter,
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
	telescope.load_extension(ext_name)
end

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope commands<cr>", opts)
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope commands<cr>", opts)
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", opts)

-- Quick maps
vim.keymap.set("n", "<C-s>f", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<C-s>j", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<M-x>", "<cmd>Telescope commands<cr>", opts)
