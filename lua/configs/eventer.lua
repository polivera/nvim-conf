local Mod = {}

Mod.load = function(opts)
	local conf = {
		["*.lua"] = {
			"stylua ###file###",
		},

		["*.go"] = {
			"gosimports -w ###file###",
		},
	}
	require("eventer").setup(opts or conf)
end

return Mod
