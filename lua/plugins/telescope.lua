local function setup_plugin()
  -- Set the global ignore patterns
  local ignore_patterns = {
    "node_modules",
    "vendor",
    ".git",
    "target",
    "dist",
    "build",
    "%.lock",
  }

  local extensions = {
    fzf = function(_)
      return {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      }
    end,
    undo = function(_)
      return {
        use_delta = true,
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      }
    end,
    ["ui-select"] = function(_)
      return {
        require("telescope.themes").get_dropdown({
          -- Custom theme options for ui-select
          borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
          width = 0.8,
          previewer = false,
        }),
      }
    end,
  }

  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")

  local telescope_settings = {
    -- Base configuration
    defaults = {
      mappings = {
        n = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-g>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["?"] = actions.which_key,
          ["<C-u>"] = false, -- Clear the default Ctrl-u binding
          ["<C-d>"] = false, -- Clear the default Ctrl-d binding
          ["<C-f>"] = action_layout.toggle_preview, -- Toggle preview window
        },
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-g>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<C-u>"] = false, -- Clear the default Ctrl-u binding
          ["<C-d>"] = false, -- Clear the default Ctrl-d binding
          ["<C-f>"] = action_layout.toggle_preview, -- Toggle preview window
        },
      },
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden", -- Search hidden files
        "--glob=!.git/", -- Don't search in .git directories
      },
      initial_mode = "insert",
      set_env = { ["COLORTERM"] = "truecolor" },
      -- Layout configuration
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      layout_strategy = "horizontal",
      color_devicons = true,
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55, -- Slightly larger preview
          results_width = 0.45,
        },
        vertical = {
          mirror = false,
          preview_height = 0.5,
        },
        width = 0.87, -- Slightly smaller for better focus
        height = 0.80, -- Slightly smaller for better focus
        preview_cutoff = 120,
      },
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      file_sorter = require("telescope.sorters").get_fuzzy_file, -- Use fuzzy file sorter for better results
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      -- Other
      file_ignore_patterns = ignore_patterns,
      path_display = { "smart" }, -- Use smart path display
      dynamic_preview_title = true, -- Show file info in preview title
      results_title = false, -- Remove the results title
      prompt_title = false, -- Remove the prompt title
    },
    -- Pickers configurations
    pickers = {
      find_files = {
        hidden = true, -- Show hidden files
        follow = true, -- Follow symlinks
      },
      live_grep = {
        additional_args = function()
          return { "--hidden" } -- Always search hidden files
        end,
      },
      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer, -- Delete buffer from buffers list
          },
          n = {
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
      -- Configure git_bcommits to open commits in new buffers
      git_bcommits = {
        mappings = {
          i = {
            -- Override default behavior to open in new splits instead of replacing
            ["<CR>"] = false,
            --             ["<C-s>"] = actions.git_create_shadow_buffer, -- Open in a shadow buffer
            ["<C-o>"] = actions.git_checkout_current_buffer, -- Original behavior
            ["<C-h>"] = function(prompt_bufnr)
              -- Open in a horizontal split
              actions.close(prompt_bufnr)
              vim.cmd("Git difftool")
            end,
          },
          n = {
            ["<CR>"] = false,
            --             ["s"] = actions.git_create_shadow_buffer,
            ["o"] = actions.git_checkout_current_buffer,
            ["h"] = function(prompt_bufnr)
              actions.close(prompt_bufnr)
              vim.cmd("Git difftool")
            end,
          },
        },
      },
      lsp_references = {
        path_display = { "truncate" },
        show_line = true,
      },
      help_tags = {
        layout_config = {
          preview_width = 0.6,
        },
      },
    },
    -- extensions
    extensions = {},
  }

  -- Apply extension configurations
  for ext_name, ext_config in pairs(extensions) do
    telescope_settings.extensions[ext_name] = ext_config()
  end

  -- Setup telescope with our settings
  telescope.setup(telescope_settings)

  -- Load extensions
  for ext_name, _ in pairs(extensions) do
    telescope.load_extension(ext_name)
  end

  -- Keymaps with descriptive comments
  local opts = { noremap = true, silent = true }

  -- File navigation
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", opts) -- New: Git files
  vim.keymap.set("n", "<leader>fj", "<cmd>Telescope live_grep<cr>", opts)
  vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", opts) -- New: Search word under cursor

  -- Buffer management
  vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- Changed from fu to fb for consistency
  vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opts) -- Changed meaning: Recent files

  -- Help & Commands
  vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
  vim.keymap.set("n", "<leader>fm", "<cmd>Telescope keymaps<cr>", opts) -- Changed meaning: Show keymaps
  vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", opts) -- Changed from fn to fc for consistency
  vim.keymap.set("n", "<leader>fs", "<cmd>Telescope resume<cr>", opts) -- Changed from fr to fs: Search resume

  -- LSP related
  vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opts) -- New: Show diagnostics
  vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", opts) -- New: Document symbols

  -- Git related
  vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts) -- New: Git branches
  vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts) -- New: Git commits
  vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts) -- New: Git status
  -- Use 's' to view commit in shadow buffer
  -- Use 'o' to checkout the version
  -- Use 'h' to use diff tool
  vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_bcommits<cr>", opts) -- New: File history (buffer commits)

  -- New: Undo history
  vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", opts)

  -- Quick maps (leaving as is, but with more descriptive names)
  vim.keymap.set("n", "<C-s>f", "<cmd>Telescope find_files<cr>", opts)
  vim.keymap.set("n", "<C-s>j", "<cmd>Telescope live_grep<cr>", opts)
  vim.keymap.set("n", "<M-x>", "<cmd>Telescope commands<cr>", opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Additional helpful dependencies
      "nvim-tree/nvim-web-devicons", -- For file icons
      "debugloop/telescope-undo.nvim", -- For undo history visualization
      "nvim-telescope/telescope-ui-select.nvim", -- For better UI selection menus
    },
    config = setup_plugin,
  },
}
