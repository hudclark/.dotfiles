return {
  {
    "saghen/blink.cmp",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      -- "sources.default",
    },
    sources = {
      default = { "lsp", "path" },
    },
  },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     provider = "openai",
  --     behaviour = {
  --       -- Don't need this. I'm using copiliot + blink
  --       auto_suggestions = false,
  --     },
  --     file_selector = {
  --       provider = "fzf",
  --       provider_opts = {},
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Options",
        mode = { "n", "v" },
      },
      {
        "<leader>ae",
        "<cmd>CodeCompanion<cr>",
        desc = "Execute CodeCompanion",
        mode = { "n", "v" },
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },
      opts = {
        -- Set debug logging
        log_level = "DEBUG",
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --     },
  --     panel = { enabled = true },
  --   },
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = {
  --     preselect = require("cmp").PreselectMode.None,
  --     completion = {
  --       completeopt = "menu,menuone,noinsert,noselect",
  --     },
  --     experimental = {
  --       ghost_text = false,
  --     },
  --   },
  -- opts = function(_, opts)
  --   local cmp = require("cmp")
  --
  --   opts.preselect = cmp.PreselectMode.None
  --   opts.completion = {
  --     completeopt = "menu,menuone,noinsert,noselect",
  --   }
  --   opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
  --     ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --     ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --     ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
  --   })
  --
  --   -- Remove copilot from cmp sources. I prefer to use the ghost text
  --   -- local copilot_idx = -1
  --   -- for idx, source in ipairs(opts.sources) do
  --   --   if source.name == "copilot" then
  --   --     copilot_idx = idx
  --   --     break
  --   --   end
  --   -- end
  --   -- if copilot_idx ~= -1 then
  --   --   table.remove(opts.sources, copilot_idx)
  --   -- end
  -- end,
  -- },
}
