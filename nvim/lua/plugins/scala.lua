-- Overrides for LazyVim's lang.scala extra (imported in config/lazy.lua).
return {
  {
    "scalameta/nvim-metals",
    opts = function(_, metals_config)
      -- The extra's on_attach calls require("metals").setup_dap()
      -- unconditionally, but it declares nvim-dap as `optional = true`. Without
      -- nvim-dap installed that throws on every Metals attach:
      --   You can not call require("metals").setup_dap() without `nvim-dap` ...
      -- Set DAP up only when nvim-dap is actually there, so adding the dap
      -- extra later starts working on its own.
      metals_config.on_attach = function(_, _)
        if pcall(require, "dap") then
          require("metals").setup_dap()
        end
      end

      -- Import a build without asking, so the question below never needs an
      -- answer for the one case that matters.
      metals_config.settings.automaticImportBuild = "all"

      -- Never draw a prompt for a server message request. Decline in silence.
      --
      -- Metals asks questions through window/showMessageRequest, and both ways
      -- of answering are unusable here:
      --   * Neovim's built-in handler calls vim.ui.select inside a coroutine
      --     and yields for the callback to resume it. LazyVim routes
      --     vim.ui.select to the snacks picker, which never resumes it, so the
      --     editor locks and keys land in the buffer behind a dead picker.
      --   * vim.fn.inputlist answers without freezing, but draws an unreadable
      --     block over the text.
      --
      -- Declining is the wanted behaviour, not a workaround. Format on save
      -- stays on, so:
      --   * a project WITH .scalafmt.conf formats with its own config, and
      --     Metals never asks anything.
      --   * a project WITHOUT one (a scratch script) makes Metals ask how to
      --     proceed. That request is declined, so the save does nothing and
      --     draws nothing.
      -- Every work repo here carries its own .scalafmt.conf, pinned to its own
      -- scalafmt version, so formatting keeps matching what CI expects.
      --
      -- Nothing is reported, to keep saves quiet. If Metals seems to be
      -- waiting on something, run :MetalsRunDoctor, or :MetalsImportBuild to
      -- import a build by hand.
      metals_config.handlers = metals_config.handlers or {}
      metals_config.handlers["window/showMessageRequest"] = function()
        return vim.NIL
      end

      return metals_config
    end,
  },
}
