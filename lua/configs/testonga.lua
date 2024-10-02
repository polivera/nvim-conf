local testonga = require("testonga")

testonga.setup()

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>tf", "<cmd>Testonga file<cr>", opts)
vim.keymap.set("n", "<leader>tl", "<cmd>Testonga last<cr>", opts)
