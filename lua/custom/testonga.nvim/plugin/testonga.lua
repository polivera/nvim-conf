-- Testonga plugin
local testonga = require("testonga")

vim.api.nvim_create_user_command("Testonga", function(args)
	local sub_cmd = args.fargs[1]
	if sub_cmd == "file" then
		testonga.show_test_in_file()
	else
		print("Unknown sub-command: " .. sub_cmd)
	end
end, {
	nargs = "*",
	complete = function()
		return { "file" }
	end,
})
