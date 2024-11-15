return {
	{
		"ariel-frischer/bmessages.nvim",
		event = "CmdlineEnter",
		opts = {},
		config = function()
			require("configs.bmessages")
		end,
	},
}
