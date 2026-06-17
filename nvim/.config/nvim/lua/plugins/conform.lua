return {
  -- conform.nvim: Plugin for automatically formatting code
  -- Supports multiple formatters and can run them sequentially
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      },
    },
  },
}
