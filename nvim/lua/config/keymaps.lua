-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- inspired from https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/core/keymaps.lua

-- set leader set to space
vim.g.mapleader = " "

-- do mappings (n is for in normal mode, i for insert mode etc.)
local nnoremap = require("config._keymap").nnoremap
local inoremap = require("config._keymap").inoremap
local vnoremap = require("config._keymap").vnoremap
local xnoremap = require("config._keymap").xnoremap

---------------------
-- General Keymaps
---------------------

-- to escape to netrw
nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- use jk to exit insert mode
inoremap("<leader>jk", "<ESC>")
inoremap("<leader>kj", "<ESC>")

-- clear search highlights
nnoremap("<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
nnoremap("x", '"_x')

-- increment/decrement numbers
nnoremap("<leader>+", "<C-a>") -- increment
nnoremap("<leader>-", "<C-x>") -- decrement

-- window management
nnoremap("<leader>sv", "<C-w>v")        -- split window vertically
nnoremap("<leader>sh", "<C-w>s")        -- split window horizontally
nnoremap("<leader>se", "<C-w>=")        -- make split windows equal width & height
nnoremap("<leader>sx", ":close<CR>")    -- close current split window

nnoremap("<leader>to", ":tabnew<CR>")   -- open new tab
nnoremap("<leader>tx", ":tabclose<CR>") -- close current tab
nnoremap("<leader>tn", ":tabn<CR>")     --  go to next tab
nnoremap("<leader>tp", ":tabp<CR>")     --  go to previous tab

-- stay in visual mode after indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- when going up/down half pages or going through search, recentre in the middle
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- NO LONGER NEEDED AS IN LAZYVIM DEFAULT REMAPS
-- -- ALT+j/k to move line down/up (https://vim.fandom.com/wiki/Moving_lines_up_or_down)
-- nnoremap("<Esc>j", ":m .+1<CR>==")
-- nnoremap("<Esc>k", ":m .-2<CR>==")
-- inoremap("<Esc>j", "<Esc>:m .+1<CR>==gi")
-- inoremap("<Esc>k", "<Esc>:m .-2<CR>==gi")
-- vnoremap("<Esc>j", ":m '>+1<CR>gv=gv")
-- vnoremap("<Esc>k", ":m '<-2<CR>gv=gv")

-- ALT+J/K to move line down/up
nnoremap("<Esc>J", "Yp==")
nnoremap("<Esc>K", "YP==")
inoremap("<Esc>J", "<Esc>YP==gi")
inoremap("<Esc>K", "<Esc>Yp==gi")
inoremap("<Esc>K", "<Esc>Yp==gi")
vnoremap("<Esc>J", "YPgv=gv")
vnoremap("<Esc>K", "YPgv=gv") -- no idea how to do this properly!?
-- vnoremap("<Esc>K", '<C-u>line("\'>") - line("\'<") + 1<cr>')

-- Don't let cursor move when using J
nnoremap("J", "mzJ`z")

-- stops pasted over stuff going into register
xnoremap("<leader>p", '"_dP')

-- yank/delete into clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- replace current word globally
nnoremap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

----------------------
-- Plugin Keybinds
----------------------

-- -- vim-maximizer
-- nnoremap("<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- -- nvim-tree
-- nnoremap("<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")  -- find files within current working directory, respects .gitignore
nnoremap("<leader>fs", "<cmd>Telescope live_grep<cr>")   -- find string in current working directory as you type
nnoremap("<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")     -- list open buffers in current neovim instance
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")   -- list available help tags

-- telescope git commands (not on youtube nvim video)
nnoremap("<leader>gc", "<cmd>Telescope git_commits<cr>")   -- list all git commits (use <cr> to checkout) ["gc" for git commits]
nnoremap("<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
nnoremap("<leader>gb", "<cmd>Telescope git_branches<cr>")  -- list git branches (use <cr> to checkout) ["gb" for git branch]
nnoremap("<leader>gs", "<cmd>Telescope git_status<cr>")    -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
nnoremap("<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- format with ALT+f if formater exists in null_ls / lsp
inoremap("<Esc>F", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<cr>", { silent = true })
nnoremap("<Esc>F", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<cr>", { silent = true })
vnoremap("<Esc>F", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<cr>gv", { silent = true })
-- inoremap("<Esc>F", "<cmd>update<cr>", { silent = true })
-- nnoremap("<Esc>F", "<cmd>update<cr>", { silent = true })
-- vnoremap("<Esc>F", "<cmd>update<cr>gv", { silent = true })

-- diagnostics
nnoremap("<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true }) -- open error/warning texts in floating window
nnoremap("<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })  -- go to previous error/warning
nnoremap("<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })  -- go to next error/warning
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
nnoremap("<leader>dd", "<cmd>Telescope diagnostics<CR>", { silent = true })           -- open error/warnings in telescope window
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- nnoremap('<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { silent = true })

-- tmux
nnoremap("<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
nnoremap("<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
nnoremap("<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
nnoremap("<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

-- TODO: swap round default nvim-tree calls
