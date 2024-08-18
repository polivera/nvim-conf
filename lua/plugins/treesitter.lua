return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/playground" },
		},
		config = function()
			require("configs.treesitter")
		end,
	},
}
