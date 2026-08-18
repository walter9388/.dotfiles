-- Only load under tmux. Inside herdr, plugins/herdr.lua owns ctrl+hjkl instead
-- and the two would otherwise both map it.
return { { "christoomey/vim-tmux-navigator", cond = vim.env.TMUX ~= nil } }
