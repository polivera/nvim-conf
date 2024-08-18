local Mod = {}

Mod.load = function(opts)
	local conf = {
		-- TODO: I should do a merge here instead of replacing
		["*.lua"] = { "stylua ###file###" },
		["*.go"] = { "gosimports -w ###file###" },
		["*.templ"] = { "templ fmt ###file### && templ generate -f ###file###" },
		["*.json"] = { "prettier -w ###file###" },
		["*.js"] = { "prettier -w ###file###" },
		["*.css"] = { "prettier -w ###file###" },
		["*.scss"] = { "prettier -w ###file###" },
		["*.html"] = { "prettier -w ###file###" },
		["*.yaml"] = { "prettier -w ###file###" },
		["*.sh"] = { "shfmt -l -w ###file###" },
		["*.php"] = { "php-cs-fixer fix ###file### --rules=@PSR12" },
	}
	require("eventer").setup(opts or conf)
end

return Mod
