return {
	{
		"xapitan/eventer.nvim",
		dev = true,
		config = function()
			require("configs.eventer").load()
		end,
	},
}
