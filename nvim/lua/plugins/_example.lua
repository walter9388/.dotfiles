-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

if true then
  return {}
end
-- local nnoremap = require("config._keymap").nnoremap

return {
  -- -- COLOURSCHEMES
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "bluz71/vim-nightfly-colors" },
  --
  -- -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "nightfly",
  --   },
  -- },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true, enabled = false },
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",

        -- LSPs
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "astro-language-server",
        "emmet-ls",
        "pyright",
        "rust-analyzer",

        -- null-ls
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
        "black", -- python formatter
        "mypy", -- python static analyzer
        "ruff", -- python linter
        "rustfmt", -- rust formatter
      },
    },
  },

  -- -- themes (set which theme is used in after/plugins/color.lua)
  -- { "folke/tokyonight.nvim" },

  -- tmux & split window navigation
  { "christoomey/vim-tmux-navigator" },

  -- maximises and restores current window
  { "szw/vim-maximizer" },

  -- -- essential plugins
  -- { "tpope/vim-surround" }, -- add, delete, change surroundings (it's awesome)
  -- { "inkarkat/vim-ReplaceWithRegister" }, -- replace with register contents using motion (gr + motion)

  -- -- commenting with gc
  -- { "numToStr/Comment.nvim" },

  -- -- file explorer
  -- { "nvim-tree/nvim-tree.lua" },

  -- -- vs-code like icons
  -- { "nvim-tree/nvim-web-devicons" },

  -- -- statusline
  -- { "nvim-lualine/lualine.nvim" },

  -- -- fuzzy finding w/ telescope
  -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- dependency for better sorting performance
  -- { "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder

  -- -- autocompletion
  -- { "hrsh7th/nvim-cmp" }, -- completion plugin
  -- { "hrsh7th/cmp-buffer" }, -- source for text in buffer
  -- { "hrsh7th/cmp-path" }, -- source for file system paths
  -- { "hrsh7th/cmp-nvim-lua" },

  -- snippets
  { "L3MON4D3/LuaSnip" }, -- snippet engine
  { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
  { "rafamadriz/friendly-snippets" }, -- useful snippets

  -- -- managing & installing lsp servers, linters & formatters
  -- { "williamboman/mason.nvim" }, -- in charge of managing lsp servers, linters & formatters
  -- { "williamboman/mason-lspconfig.nvim" }, -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  { "neovim/nvim-lspconfig" }, -- easily configure language servers
  { "hrsh7th/cmp-nvim-lsp" }, -- for autocompletion
  { "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
  { "jose-elias-alvarez/typescript.nvim" }, -- additional functionality for typescript server (e.g. rename file & update imports)
  { "onsails/lspkind.nvim" }, -- vs-code like icons for autocompletion
  { "simrat39/rust-tools.nvim" }, -- Adds extra functionality over rust analyzer

  -- -- formatting & linting
  -- { "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
  -- { "jayp0521/mason-null-ls.nvim" }, -- bridges gap b/w mason & null-ls
  -- { "sbdchd/neoformat" }, -- use :Neoformat to directly run prettier

  -- -- python debugging
  -- { "mfussenegger/nvim-dap" },
  -- { "mfussenegger/nvim-dap-python" },

  -- -- treesitter configuration
  -- {
  --   -- Please make sure you install markdown and markdown_inline parser
  --   -- (via `:TSInstall markdown markdown_inline`)
  --   "nvim-treesitter/nvim-treesitter",
  --   run = function()
  --     local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
  --     ts_update()
  --   end,
  -- },

  -- -- auto closing
  -- { "windwp/nvim-autopairs" }, -- autoclose parens, brackets, quotes, etc...
  -- { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags

  -- git integration
  { "lewis6991/gitsigns.nvim" }, -- show line modifications on left hand side

  -- toggleterm (in editor terminals)
  --use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  --  require("toggleterm").setup()
  --end}

  -- lazygit
  --use 'kdheepak/lazygit.nvim'
}
