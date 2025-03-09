local function setup_plugin()
  require("diffview").setup({
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  })

  -- Add keybindings
  vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { silent = true })
  vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", { silent = true })
  vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { silent = true })
end

return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup_plugin,
  },
}

