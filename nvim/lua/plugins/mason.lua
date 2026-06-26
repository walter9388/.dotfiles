return {
  -- NOTE: language servers (vtsls, pyright, ruff, rust-analyzer, tailwindcss,
  -- astro, etc.) are installed automatically by the LazyVim language extras
  -- imported in lua/config/lazy.lua. Only list extra CLI tools here that the
  -- extras don't pull in themselves.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- lua formatter (conform)
        "shfmt", -- shell formatter (conform)
        "shellcheck", -- shell linter
        "mypy", -- python type checker (nvim-lint, see linting.lua)
      },
    },
  },
}
