return {
  "neovim/nvim-lspconfig",
  opts = {
    codelens = { enabled = true },
    servers = {
      -- Go settings
      gopls = {
        settings = {
          gopls = {
            analyses = {
              fieldalignment = false,
            },
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = true,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = true,
            },
          },
        },
      },
    },
  },
}
