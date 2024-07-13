local neogit = require("neogit")
neogit.setup({})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>og", "<cmd>Neogit<cr>", opts)
vim.keymap.set("n", "<leader>od", "<cmd>DiffviewOpen<cr>", opts)
vim.keymap.set("n", "<leader>ol", "<cmd>Neogit log<cr>", opts)
