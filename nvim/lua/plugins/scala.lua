-- Overrides for LazyVim's lang.scala extra (imported in config/lazy.lua).
--
-- The extra's on_attach calls require("metals").setup_dap() unconditionally,
-- but it declares nvim-dap as `optional = true`. Without nvim-dap installed
-- that throws on every Metals attach:
--   You can not call require("metals").setup_dap() without `nvim-dap` ...
-- Set DAP up only when nvim-dap is actually there, so adding the dap extra
-- later starts working on its own.
return {
  {
    "scalameta/nvim-metals",
    opts = function(_, metals_config)
      metals_config.on_attach = function(_, _)
        if pcall(require, "dap") then
          require("metals").setup_dap()
        end
      end
      return metals_config
    end,
  },
}
