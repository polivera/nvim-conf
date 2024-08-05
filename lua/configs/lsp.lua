-- Configure LSP
-- This code is (mostly) copy from neovim kickstart
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Define servers configuration to be used in the lsp
local servers = {
	-- clangd = {},
	gopls = {
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = false,
				buildFlags = { "-tags=unit,integration,e2e" },
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = false,
			},
		},
	},
	templ = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
	cssls = {
		filetypes = { "scss", "less", "css" },
	},
	html = {
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			provideFormatter = false,
		},
	},
	tsserver = {},
	phpactor = {},
	bashls = {},
}

-- Add more tools for Mason to install
local other_tools = {
	"stylua", -- Used to format Lua code
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("xap-lsp-attach", { clear = true }),
	callback = function(event)
		-- Helper method
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to the definition of the word under your cursor.
		map("<leader>ld", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		-- Find references for the word under your cursor.
		map("<leader>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		-- Jump to the implementation of the word under your cursor.
		map("<leader>li", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		-- Jump to the type of the word under your cursor.
		map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		-- Fuzzy find all the symbols in your current document.
		map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		-- Fuzzy find all the symbols in your current workspace.
		map("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		-- Rename the variable under your cursor.
		map("<leader>ln", vim.lsp.buf.rename, "[R]e[n]ame")
		-- Execute a code action, usually your cursor needs to be on top of an error
		map("<leader>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
		-- Opens a popup that displays documentation about the word under your cursor
		map("<leader>lk", vim.lsp.buf.hover, "Hover Documentation")
		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("<leader>lc", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following autocommand is used to enable inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Ensure the servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu.
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, other_tools)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			-- This handles overriding only values explicitly passed
			-- by the server configuration above. Useful when disabling
			-- certain features of an LSP (for example, turning off formatting for tsserver)
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
