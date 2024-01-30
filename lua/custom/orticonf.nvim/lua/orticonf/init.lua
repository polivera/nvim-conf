local OC = {}

local configs = nil

OC.setup = function(config_file_name)
	config_file_name = config_file_name or ".orticonf.lua"

	local orticonf_file_path = vim.fn.expand("%:p") .. config_file_name
	local ok = false

	ok, configs = pcall(dofile, orticonf_file_path)
	if not ok then
		print(".orticonf.lua file not found")
		return
	end

	print(configs["ortiexec"]()["*.go"][1])
end

return OC
