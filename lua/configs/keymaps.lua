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
vim.keymap.set("n", "<C-s>s", ":w<cr>", opts)

-- To upper / to lower
vim.keymap.set({ "n", "v" }, "tu", "gU", opts)
vim.keymap.set({ "n", "v" }, "tl", "gu", opts)

-- Navigate Buffers
vim.keymap.set("n", "<Tab>", ":bnext<cr>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>", opts)
vim.keymap.set("n", "<leader>q", ":bw<cr>", opts)

-- Cancel with ctrl + g
vim.keymap.set({ "i", "v", "x" }, "<C-g>", "<esc>", opts)

-- Stay in visual mode after move code
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move tabs in normal mode
vim.keymap.set("n", "<", "<<", opts)
vim.keymap.set("n", ">", ">>", opts)

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
