return {
  -- add gruvbox
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1

      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_foreground = "original"
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "soft",
      italic = {
        comments = true,
        strings = false,
      },
      palette_overrides = {
        neutral_red = "#fb4934",
      },
    },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
