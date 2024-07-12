local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("telescope").load_extension("dap")
require("dap-go").setup({
	delve = {
		build_flags = "-tags=unit,integration,e2e",
	},
})

-- TODO: Config dap executable here

--Example
--local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
--      if elixir_ls_debugger ~= "" then
--        dap.adapters.mix_task = {
--          type = "executable",
--          command = elixir_ls_debugger,
--        }
--
--        dap.configurations.elixir = {
--          {
--            type = "mix_task",
--            name = "phoenix server",
--            task = "phx.server",
--            request = "launch",
--            projectDir = "${workspaceFolder}",
--            exitAfterTaskReturns = false,
--            debugAutoInterpretAllModules = false,
--          },
--        }

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)

-- Eval var under cursor
vim.keymap.set("n", "<leader>?", function()
	require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F9>", dap.restart)
vim.keymap.set("n", "<F10>", dap.close)

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
