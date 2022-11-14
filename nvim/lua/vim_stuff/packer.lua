-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- themes
  use 'folke/tokyonight.nvim'

  -- toggleterm (in editor terminals)
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}

  -- lazygit
  use 'kdheepak/lazygit.nvim'
end)

-- REMEMBER TO SOURCE THIS FILE TO USE PACKER!!! (enter :so in nvim)
