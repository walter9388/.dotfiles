return {
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
}
