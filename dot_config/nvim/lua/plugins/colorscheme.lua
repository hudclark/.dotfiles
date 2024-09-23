return {
  -- add gruvbox
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

  { "rebelot/kanagawa.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
