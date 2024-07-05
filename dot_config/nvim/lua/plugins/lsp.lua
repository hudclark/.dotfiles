return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      codelens = { enabled = false },
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
        -- Scala
        metals = {
          settings = {
            showImplicitArguments = false,
          },
        },
      },
    },
  },
}
