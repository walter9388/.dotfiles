-- Seamless navigation and resizing across Neovim splits and herdr panes.
-- The herdr half lives in dotfiles/herdr/config.toml ([[keys.command]] blocks)
-- and needs the herdr plugin installed once:
--   herdr plugin install lmilojevicc/herdr-splits.nvim
--
-- ctrl+hjkl   navigate  (replaces vim-tmux-navigator)
-- alt+hjkl    resize    (nvim splits only; prefix+hjkl resizes herdr panes)
--
-- Only loads inside a herdr pane, so it can't clash with vim-tmux-navigator
-- when running under tmux instead.
return {
  {
    "lmilojevicc/herdr-splits.nvim",
    cond = vim.env.HERDR_ENV == "1",
    event = "VeryLazy",
    config = function()
      require("herdr-splits").setup({
        at_edge = "wrap",
        unzoom_on_nav = true,
        ignored_filetypes = {
          "snacks_dashboard",
          "snacks_explorer",
          "snacks_picker",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "aerial",
          "quickfix",
        },
      })
    end,
    keys = {
      { "<C-h>", function() require("herdr-splits").move_cursor_left() end, desc = "Navigate left" },
      { "<C-j>", function() require("herdr-splits").move_cursor_down() end, desc = "Navigate down" },
      { "<C-k>", function() require("herdr-splits").move_cursor_up() end, desc = "Navigate up" },
      { "<C-l>", function() require("herdr-splits").move_cursor_right() end, desc = "Navigate right" },
      { "<M-h>", function() require("herdr-splits").resize_left() end, desc = "Resize left" },
      { "<M-j>", function() require("herdr-splits").resize_down() end, desc = "Resize down" },
      { "<M-k>", function() require("herdr-splits").resize_up() end, desc = "Resize up" },
      { "<M-l>", function() require("herdr-splits").resize_right() end, desc = "Resize right" },
    },
  },
}
