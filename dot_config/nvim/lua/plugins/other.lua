return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ action = "focus", toggle = false })
        end,
        desc = "NeoTree Focus",
      },
    },
    opts = {
      filesystem = {
        group_empty_dirs = true,
      },
    },
  },
  {
    "hudclark/grpc-nvim",
    cmd = "Grpc",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/flash.nvim",
    opts = {
      label = {
        before = true,
        after = false,
      },
      modes = {
        -- disable for searching
        search = {
          enabled = false,
        },
        -- disable for f,t
        char = {
          enabled = false,
        },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  -- },
}
