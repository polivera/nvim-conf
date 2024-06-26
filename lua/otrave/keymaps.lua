-- --------------------------------------------------------------------------------------------------------------------
-- Keybinding configuration
-- --------------------------------------------------------------------------------------------------------------------

-- Default keymaps opts
local opts = { noremap = true, silent = true }

-- Set Leader Key
vim.keymap.set("", " ", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save
vim.keymap.set("n", "<leader>w", ":w<cr>", opts)

-- To upper / to lower
vim.keymap.set({ "n", "v" }, "tu", "gU", opts)
vim.keymap.set({ "n", "v" }, "tl", "gu", opts)

-- Navigate Buffers
vim.keymap.set("n", "<Tab>", ":bnext<cr>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>", opts)

-- Cancel with ctrl + g
vim.keymap.set({ "i", "v", "x" }, "<C-g>", "<esc>", opts)

-- Stay in visual mode after move code
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move tabs in normal mode
vim.keymap.set("n", "<", "<<", opts)
vim.keymap.set("n", ">", ">>", opts)

-- Move text up and down
vim.keymap.set("v", "<C-j>", ":m .+1<cr>==", opts)
vim.keymap.set("v", "<C-k>", ":m .-2<cr>==", opts)

-- Splits Management --
vim.keymap.set("n", "<leader>x", "<cmd>split<cr>", opts)
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", opts)
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>", opts)
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", opts)

-- Activate sessionizer
vim.keymap.set("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>", opts)

-- Make m yank and delete, d just delete and c change without yank
vim.keymap.set({ "n", "x" }, "m", "d", opts)
vim.keymap.set({ "n", "x" }, "M", "D", opts)
vim.keymap.set({ "n", "x" }, "mm", "dd", opts)
vim.keymap.set({ "n", "x" }, "d", '"_d', opts)
vim.keymap.set({ "n", "x" }, "D", '"_D', opts)
vim.keymap.set({ "n", "x" }, "c", '"_c', opts)
vim.keymap.set({ "n", "x" }, "C", '"_C', opts)
vim.keymap.set({ "n", "x" }, "x", '"_x', opts)
vim.keymap.set({ "n", "x" }, "X", '"_X', opts)

-- --------------------------------------------------------------------------------------------------------------------
-- PLUGINS KEYMAPS

-- Personal Debugging
vim.keymap.set("n", "<leader>ds", "<cmd>source %<cr>", opts)

-- Telescope keybinding
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope commands<cr>", opts)
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope buffers<cr>", opts)

-- Neo tree
vim.keymap.set("n", "<leader>\\", "<cmd>Neotree filesystem toggle<cr>", opts)
vim.keymap.set("n", "<leader>nl", "<cmd>Neotree filesystem toggle reveal<cr>", opts)
vim.keymap.set("n", "<leader>ns", "<cmd>Neotree git_status toggle<cr>", opts)
vim.keymap.set("n", "<leader>nu", "<cmd>Neotree buffers toggle<cr>", opts)

-- Orti test
vim.keymap.set("n", "<leader>tf", "<cmd>OrtiTestFind<cr>", opts)
vim.keymap.set("n", "<leader>tr", "<cmd>OrtiTestRun<cr>", opts)
