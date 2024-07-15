local Mod = {}

Mod.load = function(opts)
	local conf = {
		["*.lua"] = { "stylua ###file###" },
		["*.go"] = { "gosimports -w ###file###" },
		["*.json"] = { "prettier -w ###file###" },
		["*.js"] = { "prettier -w ###file###" },
		["*.css"] = { "prettier -w ###file###" },
		["*.scss"] = { "prettier -w ###file###" },
		["*.html"] = { "prettier -w ###file###" },
		["*.yaml"] = { "prettier -w ###file###" },
	}
	require("eventer").setup(opts or conf)
end

return Mod
