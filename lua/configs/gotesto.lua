local Mod = {}

Mod.load = function(opts)
	require("gotesto").setup(opts or {})
end

return Mod
