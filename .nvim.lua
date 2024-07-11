-- Setup eventer from a different place
require("configs.eventer").load({
	["*.test"] = {
		"echo '-- it works!!!' >> ###file###",
	},
})
