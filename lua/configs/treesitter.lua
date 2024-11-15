local opts = {
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"lua",
		"luadoc",
		"markdown",
		"vim",
		"vimdoc",
		"go",
		"gomod",
		"php",
	},
	ignore_install = { "org" },
	-- Autoinstall languages that are not installed
	auto_install = true,
	highlight = {
		enable = true,
		-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
		--  If you are experiencing weird indenting issues, add the language to
		--  the list of additional_vim_regex_highlighting and disabled languages for indent.
		-- additional_vim_regex_highlighting = { "ruby" },
	},
	indent = {
		enable = true,
		-- disable = { "ruby" }
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = true, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
}
-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- Prefer git instead of curl in order to improve connectivity in some environments
require("nvim-treesitter.install").prefer_git = true
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup(opts)

-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
