vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.scrolloff = 8

vim.opt.termguicolors = true

------ UNCOMMENT IF USING WSL (WINDOWS) ------
-- vim.g.clipboard = {
-- 	name = "WSLclipboard",
-- 	copy = {
-- 		["+"] = "win32yank.exe -i --crlf",
-- 		["*"] = "win32yank.exe -i --crlf",
-- 	},
-- 	paste = {
-- 		["+"] = "win32yank.exe -o --lf",
-- 		["*"] = "win32yank.exe -o --lf",
-- 	},
-- 	cache_enabled = true,
-- }
