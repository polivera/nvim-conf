local M = {}

M.setup_plugin = function()
  local lint = require("lint")
  local tool_list = require("plugins.lsp.tools")

  local linters = {}
  for k, v in pairs(tool_list.tools.linters) do
    linters[k] = { v }
  end

  -- Configure linters for specific filetypes
  lint.linters_by_ft = linters

  -- Customize linter options if needed
  -- Example for golangcilint:
  -- lint.linters.golangcilint.args = {
  --   "--fast",
  --   "--config=" .. vim.fn.expand("~/.golangci.yml"),
  -- }

  -- Set up autocommands to trigger linting
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  -- Commands and keymaps for manual linting
  vim.api.nvim_create_user_command("Lint", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })

  vim.keymap.set("n", "<leader>cl", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })

  -- Diagnostic navigation keymaps
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { desc = "List Diagnostics" })
end

M.setup_plugin()

return M
