local OC = {}

local configs = nil

---Load configuration
---@param configname string
---@param default_config table
---@return table
local loadconfig = function(configname, default_config)
	if configs ~= nil then
		local config = configs[configname] or nil
		if config ~= nil then
			return vim.tbl_deep_extend("keep", config(), default_config)
		end
	end
	return default_config
end

---Setup configuration file support
---@param config_file_name ?string
OC.setup = function(config_file_name)
	config_file_name = config_file_name or ".orticonf.lua"

	local orticonf_file_path = vim.fn.expand("%:p") .. config_file_name
	local ok = false

	ok, configs = pcall(dofile, orticonf_file_path)
	if not ok then
		print(".orticonf.lua file not found")
		return
	end
end

---Load the given configuration
---@param name string
---@param default_config table
OC.loadplugin = function(name, default_config)
	-- Check plugin really exist
	local ok, plug = pcall(require, name)
	if not ok then
		print(string.format("Plugin %s does not exist", name))
		return
	end
	-- Check we have config for the plugin or we send the detault
	plug.setup(loadconfig(name, default_config))
end

return OC
