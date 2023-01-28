-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

-- import rust-tools plugin safely
local rusttools_status, rusttools = pcall(require, "rust-tools")
if not rusttools_status then
	print("something wrong with rust-tools plugin")
	return
end

-- local keymap = vim.keymap -- for conciseness
-- do mappings (n is for in normal mode, i for insert mode etc.)
local nnoremap = require("vim_stuff.keymap").nnoremap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	nnoremap("gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	nnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	nnoremap("gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	nnoremap("<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	nnoremap("<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	nnoremap("<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	nnoremap("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	nnoremap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	nnoremap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	nnoremap("K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	nnoremap("<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		nnoremap("<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		nnoremap("<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		nnoremap("<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- options: https://github.com/microsoft/pyright/blob/main/docs/settings.md
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
		},
	},
})

rusttools.setup({
	-- -- rust-tools options
	-- tools = {
	-- 	autoSetHints = true,
	-- 	-- hover_with_actions = true,
	-- 	inlay_hints = {
	-- 		show_parameter_hints = true,
	-- 		parameter_hints_prefix = "",
	-- 		other_hints_prefix = "",
	-- 	},
	-- },

	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			-- 		-- to enable rust-analyzer settings visit:
			-- 		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			-- 		["rust-analyzer"] = {
			-- 			-- enable clippy on save
			-- 			checkOnSave = {
			-- 				enable = false,
			-- 				-- command = "clippy",
			-- 			},
			-- 		},
			-- 	},
			-- },
			-- -- tools = {
			-- -- 	autoSetHints = true,
			-- -- 	hover_with_actions = true,
			-- -- 	inlay_hints = {
			-- -- 		show_parameter_hints = false,
			-- -- 		parameter_hints_prefix = "",
			-- -- 		other_hints_prefix = "",
			-- -- 	},
			-- -- },

			["rust-analyzer"] = {
				assist = {
					importEnforceGranularity = true,
					importPrefix = "crate",
				},
				cargo = {
					allFeatures = true,
				},
				checkOnSave = {
					-- default: `cargo check`
					command = "clippy",
				},
			},
			inlayHints = {
				lifetimeElisionHints = {
					enable = true,
					useParameterNames = true,
				},
			},
		},
	},
})
