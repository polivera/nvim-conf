-- --------------------------------------------------------------------------------------------------------------------
-- Keybinding configuration
-- --------------------------------------------------------------------------------------------------------------------

-- Default keymaps opts
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

-- Set Leader Key
vim.keymap.set("", " ", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick save and quit
vim.keymap.set("n", "<leader>w", ":w<cr>", opts)
vim.keymap.set("n", "<C-s>", ":w<cr>", opts)
vim.keymap.set("n", "<leader>q", ":bw<cr>", opts)
vim.keymap.set("n", "<leader>Q", ":qa<cr>", opts)
vim.keymap.set("n", "<leader>wq", ":wq<cr>", opts)

-- Case transformation
vim.keymap.set({ "n", "v" }, "tu", "gU", opts)
vim.keymap.set({ "n", "v" }, "tl", "gu", opts)
vim.keymap.set({ "n", "v" }, "tt", "~", opts) -- Toggle case

-- Navigate Buffers
vim.keymap.set("n", "<Tab>", ":bnext<cr>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>", opts)
vim.keymap.set("n", "<leader><leader>b", ":buffers<cr>", opts)

-- Cancel with ctrl + g or escape
vim.keymap.set({ "i", "v", "x" }, "<C-g>", "<esc>", opts)

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Indentation in normal mode
vim.keymap.set("n", "<", "<<", opts)
vim.keymap.set("n", ">", ">>", opts)

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered when navigating search results and joining lines
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Maintain cursor position when joining lines with J
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Better pasting
vim.keymap.set("v", "p", '"_dP', opts) -- Don't overwrite register when pasting in visual mode

-- Activate sessionizer
vim.keymap.set("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>", opts)

-- Register management: m to cut, d to delete without yanking, c to change without yanking
vim.keymap.set({ "n", "x" }, "m", "d", opts)
vim.keymap.set({ "n", "x" }, "M", "D", opts)
vim.keymap.set({ "n", "x" }, "mm", "dd", opts)
vim.keymap.set({ "n", "x" }, "d", '"_d', opts)
vim.keymap.set({ "n", "x" }, "D", '"_D', opts)
vim.keymap.set({ "n", "x" }, "c", '"_c', opts)
vim.keymap.set({ "n", "x" }, "C", '"_C', opts)
vim.keymap.set({ "n", "x" }, "x", '"_x', opts)
vim.keymap.set({ "n", "x" }, "X", '"_X', opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)

-- Quick search and replace for word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- Quick horizontal scrolling
vim.keymap.set("n", "zh", "10zh", opts)
vim.keymap.set("n", "zl", "10zl", opts)

-- Better movement between wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- Quickfix navigation
vim.keymap.set("n", "<leader>co", ":copen<CR>", opts)
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", opts)
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", opts)
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", opts)

-- Convenient way to toggle common options
vim.keymap.set("n", "<leader>ch", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<leader>cw", ":set wrap!<CR>", opts)
vim.keymap.set("n", "<leader>cs", ":set spell!<CR>", opts)
vim.keymap.set("n", "<leader>cp", ":set paste!<CR>", opts)
vim.keymap.set("n", "<leader>cn", ":set number!<CR>", opts)
vim.keymap.set("n", "<leader>cr", ":set relativenumber!<CR>", opts)

-- Run the current file
vim.keymap.set("n", "<leader>rf", ":!%:p<CR>", opts)

-- Source current file
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", opts)

-- Centers the screen after various movements
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode with Esc
