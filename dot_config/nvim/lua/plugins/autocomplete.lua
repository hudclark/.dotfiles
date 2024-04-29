return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = { enabled = true },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      preselect = require("cmp").PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      experimental = {
        ghost_text = false,
      },
    },
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
  },
}
