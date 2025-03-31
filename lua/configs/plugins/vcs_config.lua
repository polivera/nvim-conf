local M = {}
local opts = { noremap = true, silent = true }

M.setup_diffview = function()
  require("diffview").setup({
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  })

  -- Add keybindings
  vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", opts)
  vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", opts)
  vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", opts)
end

M.setup_neogit = function()
  local neogit = require("neogit")
  neogit.setup({
    commit_editor = {
      kind = "tab",
      staged_diff_split_kind = "vsplit",
    },
    integrations = {
      telescope = true,
    },
  })

  vim.keymap.set("n", "<leader>og", "<cmd>Neogit<cr>", opts)
  vim.keymap.set("n", "<leader>od", "<cmd>DiffviewOpen<cr>", opts)
  vim.keymap.set("n", "<leader>ol", "<cmd>Neogit log<cr>", opts)
end

M.setup_gitsigns = function()
  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })

  vim.keymap.set("n", "<leader>ol", "<cmd>Gitsigns blame_line<cr>", opts)
  vim.keymap.set("n", "<leader>oa", "<cmd>Gitsigns blame<cr>", opts)
end

return M
