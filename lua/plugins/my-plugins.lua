return {
	{
		"xapitan/eventer.nvim",
		dev = true,
		config = function()
			require("configs.eventer").load()
		end,
	},
	{
		"xapitan/testonga.nvim",
		dev = true,
		config = function()
			require("testonga")
		end,
	},
	{
		"xapitan/helpoga.nvim",
		dev = true,
	},
}
