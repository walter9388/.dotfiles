local colorscheme_name = "tokyonight"
local colorscheme_name = "nightfly"
local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_name)
if not status then
    print("Colorscheme '" .. colorscheme_name .. "' not found!! (might need to update '.config/nvim/lua/vim_stuff/packer.lua'")
    return
end

-- general color options
vim.opt.background = "dark"

-- theme specific options
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true
