-- --------------------------------------------------------------------------------------------------------------------
-- List of local plugins
-- --------------------------------------------------------------------------------------------------------------------

local ortiexec_setup = function()
	local orticonf = require("orticonf")
	orticonf.setup()
	orticonf.loadplugin("ortiexec", {
		["*.lua"] = {
			"stylua ###file###",
		},
		["*.go"] = {
			"gofmt -w ###file###",
			"gosimports -w ###file###",
		},
	})
end

local ortitest_setup = function()
	local orticonf = require("orticonf")
	orticonf.setup()
	orticonf.loadplugin("ortitest", {})
end

return {
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
