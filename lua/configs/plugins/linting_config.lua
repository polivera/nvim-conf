local M = {}

M.setup_plugin = function()
  local lint = require("lint")

  -- Configure linters for specific filetypes
  lint.linters_by_ft = {
    go = { "golangcilint" },
    lua = { "luacheck" },
    php = { "phpstan" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    markdown = { "markdownlint" },
    -- Add more filetypes and their linters as needed
  }

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

return M
