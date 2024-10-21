-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		formatting.black, -- python formatter
		formatting.rustfmt, -- rust formatter
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
		diagnostics.mypy.with({ -- python linter
			-- need to get venv to pick up installed packages + library stubs (https://stackoverflow.com/a/76487663)
			extra_args = function()
				local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
				print(virtual)
				return { "--python-executable", virtual .. "/bin/python3" }
			end,
		}),
		diagnostics.ruff, --python linter
		-- diagnostics.rust_analyzer, --rust linter -- this is done via rust-tools instead
	},
	-- configure format on save https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			-- format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
						timeout_ms = 10000,
					})
				end,
			})
		end
	end,
})
