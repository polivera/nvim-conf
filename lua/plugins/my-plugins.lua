return {
	{
		"xapitan/eventer.nvim",
		dev = true,
		config = function()
			require("configs.eventer").load()
		end,
	},
	{
		"xapitan/helpoga.nvim",
		dev = true,
	},
}
