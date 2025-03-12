if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
	package.loaded["helpoga.path"] = nil
	package.loaded["helpoga.telescope"] = nil
	package.loaded["helpoga.treesitter"] = nil
	package.loaded["helpoga.window"] = nil
	package.loaded["helpoga.string"] = nil
end

local M = {}

M.buffer = require("helpoga.buffer")
M.placeholder = require("helpoga.placeholder")
M.telescope = require("helpoga.telescope")
M.treesitter = require("helpoga.treesitter")
M.window = require("helpoga.window")
M.string = require("helpoga.string")
M.markdown = require("helpoga.markdown")

return M
