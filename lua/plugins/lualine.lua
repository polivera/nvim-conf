local function get_current_file_path()
  return vim.fn.expand("%:.")
end

local function setup_plugin()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 300,
        tabline = 100,
        winbar = 300,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { get_current_file_path },
      },
      lualine_x = { "encoding", "fileformat" },
      lualine_y = { "filetype" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "location" },
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          "buffers",
          symbols = {
            modified = " ●", -- Text to show when the buffer is modified
            alternate_file = "", -- Text to show to identify the alternate file
            directory = "", -- Text to show when the buffer is a directory
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  config = setup_plugin,
}
