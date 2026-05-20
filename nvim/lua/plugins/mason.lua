return {
  -- Mason.nvim: Plugin for managing external tools (LSP servers, linters, formatters)
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "ruff", -- Python linter and formatter (fast, written in Rust)
      "basedpyright", -- Open source static type analyzer and language server for Python.
    },
  },
}
