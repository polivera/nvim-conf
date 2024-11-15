require("render-markdown").setup({
	file_types = { "markdown", "quarto" },
})

local markdown_helper = require("helpoga").markdown

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<leader>lf", function()
			markdown_helper.markdown_go_to_link()
		end, { noremap = true, silent = true, buffer = true })
	end,
})
