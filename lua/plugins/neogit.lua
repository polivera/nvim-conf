local function setup_plugin()
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

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "<leader>og", "<cmd>Neogit<cr>", opts)
  vim.keymap.set("n", "<leader>od", "<cmd>DiffviewOpen<cr>", opts)
  vim.keymap.set("n", "<leader>ol", "<cmd>Neogit log<cr>", opts)
end

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = setup_plugin,
  },
}
