-- Python type-checking via nvim-lint (modern replacement for the old none-ls
-- mypy source). Formatting + ruff linting come from the python LazyVim extra.
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "mypy" },
    },
    linters = {
      mypy = {
        -- point mypy at the active virtualenv so it picks up installed
        -- packages and library stubs (https://stackoverflow.com/a/76487663).
        -- the path is a function element so nvim-lint resolves the venv at
        -- lint time, not at startup.
        prepend_args = {
          "--python-executable",
          function()
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
            return venv .. "/bin/python3"
          end,
        },
      },
    },
  },
}
