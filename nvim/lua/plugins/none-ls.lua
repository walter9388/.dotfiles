local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local null_ls = require("null-ls")
--
-- local opts = {
--   sources = {
--     null_ls.builtins.formatting.black,
--     null_ls.builtins.diagnostics.mypy.with({
--       extra_args = function()
--         local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
--         return { "--python-executable", virtual .. "/bin/python3" }
--       end,
--     }),
--   },
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({
--         group = augroup,
--         buffer = bufnr,
--       })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = bufnr })
--         end,
--       })
--     end
--   end,
-- }

return {
  -- change none-ls config
  {
    "nvimtools/none-ls.nvim",
    enabled = true,
    -- opts copied from here: http://www.lazyvim.org/extras/lsp/none-ls#none-lsnvim
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,

        -- FROM OLD CONFIG
        --  "nls.builtins.formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        -- nls.builtins.formatting.prettier, -- js/ts formatter
        -- nls.builtins.formatting.stylua, -- lua formatter
        nls.builtins.formatting.black, -- python formatter
        -- nls.builtins.formatting.rustfmt, -- rust formatter
        -- nls.builtins.diagnostics.eslint_d.with({ -- js/ts linter
        --   -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
        --   condition = function(utils)
        --     return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
        --   end,
        -- }),
        nls.builtins.diagnostics.mypy.with({ -- python linter
          -- need to get venv to pick up installed packages + library stubs (https://stackoverflow.com/a/76487663)
          extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
            return { "--python-executable", virtual .. "/bin/python3" }
          end,
        }),
        -- nls.builtins.diagnostics.ruff, --python linter
        -- diagnostics.rust_analyzer, --rust linter -- this is done via rust-tools instead
      })

      opts.on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end
    end,
  },
}
