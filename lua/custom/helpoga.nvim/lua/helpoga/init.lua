if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.window"] = nil
end

local M = {}

M.window = require("helpoga.window")

M.window.vsplit()

return M
