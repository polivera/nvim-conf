-- --------------------------------------------------------------------------------------------------------------------
-- List of local plugins
-- --------------------------------------------------------------------------------------------------------------------
return {
	-- I think I should rename this to formatter
	{
		dir = vim.fn.stdpath("config") .. "/lua/custom/ortiexec.nvim",
		dependencies = {
			{
				dir = vim.fn.stdpath("config") .. "/lua/custom/orticonf.nvim",
			},
		},

		config = function()
			local orticonf = require("orticonf")
			orticonf.setup()
			orticonf.setupplugin("ortiexec", {
				["*.lua"] = {
					"stylua ###file###",
				},
				["*.go"] = {
					"gofmt -w ###file###",
					"gosimports -w ###file###",
				},
			})
		end,
	},
}
