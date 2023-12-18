-- --------------------------------------------------------------------------------------------------------------------
--
-- Keybinding configuration
--
-- --------------------------------------------------------------------------------------------------------------------

-- vim.keymap.set(mode, shortcut, action_func, funcOpts)
local base_opts = { noremap = true, silent = true }

-- Set Leader Key
vim.keymap.set("", " ", "<Nop>", base_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save
vim.keymap.set("n", "<leader>w", ":w<cr>", base_opts)

-- To upper / to lower
vim.keymap.set({"n", "v"}, "tu", "gU", base_opts)
vim.keymap.set({"n", "v"}, "tl", "gu", base_opts)

-- Navigate Buffers
vim.keymap.set("n", "<Tab>", ":bnext<cr>", base_opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>", base_opts)

-- Cancel with ctrl + g
vim.keymap.set({"i", "v"}, "<C-g>", "<esc>", base_opts)

-- Stay in visual mode after move code
vim.keymap.set("v", "<", "<gv", base_opts)
vim.keymap.set("v", ">", ">gv", base_opts)

-- Move tabs in normal mode
vim.keymap.set("n", "<", "<<", base_opts)
vim.keymap.set("n", ">", ">>", base_opts)

-- Move text up and down
vim.keymap.set("v", "<C-j>", ":m .+1<cr>==", base_opts)
vim.keymap.set("v", "<C-k>", ":m .-2<cr>==", base_opts)

-- Cancel visual mode
vim.keymap.set("v", "<C-g>", "<esc>", base_opts)

-- Splits Management --
vim.keymap.set("n", "<leader>x", "<cmd>split<cr>", base_opts)
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", base_opts)
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>", base_opts)
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", base_opts)

-- Activate sessionizer
vim.keymap.set("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>", base_opts)

-- Make m yank and delete, d just delete and c change without yank
vim.keymap.set({ "n", "x" }, "m", "d", base_opts)
vim.keymap.set({ "n", "x" }, "M", "D", base_opts)
vim.keymap.set({ "n", "x" }, "mm", "dd", base_opts)
vim.keymap.set({ "n", "x" }, "d", '"_d', base_opts)
vim.keymap.set({ "n", "x" }, "D", '"_D', base_opts)
vim.keymap.set({ "n", "x" }, "c", '"_c', base_opts)
vim.keymap.set({ "n", "x" }, "C", '"_C', base_opts)
vim.keymap.set({ "n", "x" }, "x", '"_x', base_opts)
vim.keymap.set({ "n", "x" }, "X", '"_X', base_opts)

-- Telescope keybinding
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", base_opts)
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope live_grep<cr>", base_opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", base_opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope commands<cr>", base_opts)
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope buffers<cr>", base_opts)

-- Neo tree
vim.keymap.set("n", "<leader>\\", "<cmd>Neotree filesystem toggle<cr>", base_opts)
vim.keymap.set("n", "<leader>tt", "<cmd>Neotree filesystem toggle reveal<cr>", base_opts)
vim.keymap.set("n", "<leader>tg", "<cmd>Neotree git_status toggle<cr>", base_opts)
vim.keymap.set("n", "<leader>ts", "<cmd>Neotree buffers toggle<cr>", base_opts)

