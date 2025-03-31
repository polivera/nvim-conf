local M = {}

M.setup_plugin = function()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          git = {
            unstaged = "┃",
            staged = "┃",
            unmerged = "═",
            renamed = "➜",
            untracked = "┆",
            deleted = "_",
            ignored = "◌",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
  })

  -- Add keybindings
  vim.keymap.set("n", "<leader>et", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })
  vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { silent = true, desc = "Find in NvimTree" })
end

return M
