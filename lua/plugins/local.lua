-- --------------------------------------------------------------------------------------------------------------------
-- List of local plugins
-- --------------------------------------------------------------------------------------------------------------------

local orticonf_setup = function()
	require("orticonf").setup()
end

local ortiexec_setup = function()
	local conf = {
		["*.lua"] = {
			"stylua ###file###",
		},
		["*.go"] = {
			"gofmt -w ###file###",
			"gosimports -w ###file###",
		},
	}
	require("orticonf").loadplugin("ortiexec", conf)
end

local ortitest_setup = function()
	local conf = {}
	require("orticonf").loadplugin("ortitest", conf)
end

return {
	-- Orticonf
	{
		"polivera/orticonf.nvim",
		dev = true,
		dependencies = {
			{ "polivera/ortiutils.nvim", dev = true },
		},
		config = orticonf_setup,
	},
	-- Ortiexec
	{
		"polivera/ortiexec.nvim",
		dev = true,
		dependencies = {
			{ "polivera/orticonf.nvim", dev = true },
			{ "polivera/ortiutils.nvim", dev = true },
			{ "polivera/ortidebug.nvim", dev = true },
		},
		config = ortiexec_setup,
	},
	-- Ortitest
	{
		"polivera/ortitest.nvim",
		dev = true,
		dependencies = {
			{ "polivera/orticonf.nvim", dev = true },
			{ "polivera/ortiutils.nvim", dev = true },
			{ "polivera/ortidebug.nvim", dev = true },
		},
		config = ortitest_setup,
	},
}
