return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            -- It allows basedpyright to handle only the Type Checking and not the linter, since Ruff handles the linter.
            analysis = {
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportUndefinedVariable = "none",
                reportUnusedVariable = "none",
                reportUnusedImport = "none",
                reportDuplicateImport = "none",
              },
            },
          },
        },
      },
    },
  },
}
