return {

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "soft",
        italic = {
          comments = true,
          strings = false
        },
        palette_overrides = {
          neutral_red = "#fb4934"
        }
      })

      vim.cmd("colorscheme gruvbox")
    end
  },

  -- Nvim Tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "\\", "<cmd>NvimTreeToggle<CR>"},
      { "<c-\\>", "<cmd>NvimTreeFocus<CR>"},
    },
    opts = {
      reload_on_bufenter = true,
      diagnostics = {
        enable = true
      },
      update_focused_file = {
        enable = true
      },
      filesystem_watchers = {
        enable = true
      },
      view = {
        adaptive_size = true,
      },
      renderer = {
        group_empty = true
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', 'd', api.fs.trash, opts('trash'))
        vim.keymap.set('n', 'i', api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set('n', 's', api.node.open.vertical, opts("Open: Vertical Split"))
      end
    }
  },

  -- fidget
  {
    "j-hui/fidget.nvim",
    opts = {
      integration = {
        ["nvim-tree"] = {
          enable = false
        }
      }
    }
  },

  -- CMP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" }
        }),
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        },
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as 
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })
        }
      })

    end
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    -- lazy = true,
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal
      require("toggleterm").setup({
        open_mapping = "<c-t>",
        shade_terminals = true,
        size = 25
      })

      -- lazygit
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "single",
        },
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      vim.keymap.set("n", "<leader>g", function()
        lazygit:toggle()
      end, {silent = true})

      -- gh dash
      local gh_dash = Terminal:new({
        cmd = "gh dash",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "single",
        },
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      vim.keymap.set("n", "<leader>d", function()
        gh_dash:toggle()
      end, {silent = true})
    end
  },

  -- vim surround
  {
    "kylechui/nvim-surround",
    config = function()
      require('nvim-surround').setup()
    end
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Octo
  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup({
        use_local_fs = true,
        picker = "fzf-lua"
      })

      vim.api.nvim_create_user_command("Reviews", "Octo search is:pr is:open review-requested:@me archived:false", {})
      vim.api.nvim_create_user_command("Prs", "Octo search is:pr state:open author:@me", {})
    end
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      options = {
        always_divide_middle = true,
        component_separators = {
          left = "",
          right = ""
        },
        globalstatus = false,
        icons_enabled = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000
        },
        section_separators = {
          left = "",
          right = ""
        },
        theme = "auto"
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff:", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      }
    }
  },

  -- grpc
  {
    "hudclark/grpc-nvim",
    cmd = "Grpc",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- tpope
  {
    "tpope/vim-sleuth"
  },

  {
    "tpope/vim-fugitive"
  },

  -- FZF
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<c-p>", function() require("fzf-lua").files() end },
      { "<leader>ff", function() require("fzf-lua").live_grep() end },
      { "<leader>fh", function() require("fzf-lua").help_tags() end },
      { "<leader>fr", function() require("fzf-lua").oldfiles() end },
      { "gd", function() require("fzf-lua").lsp_definitions() end },
      { "gr", function() require("fzf-lua").lsp_references() end },
      { "<leader>o", function() require("fzf-lua").lsp_document_symbols() end },
      { "<leader>t", function() require("fzf-lua").resume() end },
      { "<leader>ca", function() require("fzf-lua").lsp_code_actions() end },
      { "<leader>a", function() require("fzf-lua").lsp_document_diagnostics() end },
      { "<leader>A", function() require("fzf-lua").lsp_workspace_diagnostics() end },
    },
    config = function()
      -- Use native fzf + fd + bat for faster performance :)
      -- require("fzf-lua").setup({ "fzf-native" })
    end
  },

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true
        }
      })
      vim.treesitter.language.register("markdown", "octo")
    end
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})

      lspconfig.gopls.setup({})
      lspconfig.bufls.setup({})
      lspconfig.rust_analyzer.setup({})

      -- format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.format()
        end
      })

      -- mappings
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {noremap = true})
      vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {noremap = true})
      vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, {noremap = true})
      vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float(0, {scope = "line"}) end, {noremap = true})
      vim.keymap.set("i", "<c-s>", function() vim.lsp.buf.signature_help() end, {noremap = true})

      -- signcolumns
      vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})


    end
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({})
    end
  },

  -- metals
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "scala", "sc" },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        showInferredType = true,
        showImplicitConversionsAndClasses = true,
        enableSemanticHighlighting = false
      }

      metals_config.init_options.statusBarProvider = "on"

      metals_config.on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>i", function() require("metals").organize_imports() end, {noremap = true})
      end

      -- https://github.com/j-hui/fidget.nvim/issues/17#issuecomment-1083389908 
      metals_config.handlers["metals/status"] = function(err, status, ctx)
        -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
        local val = {}
        if status.hide then
          val = {kind = "end"}
        elseif status.show then
          val = {kind = "begin", message = status.text}
        elseif status.text then
          val = {kind = "report", message = status.text}
        else
          return
        end
        local info = {client_id = ctx.client_id}
        local msg = {token = "metals", value = val}
        -- call fidget progress handler
        vim.lsp.handlers["$/progress"](nil, msg, info) 
      end

      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  },

  -- flash
  {
    "folke/flash.nvim",
    config = function()
      local flash = require("flash")

      flash.setup({
        label = {
          before = true,
          after = false
        },
        modes = {
          search = {
            enabled = false
          }
        }
      })

      vim.api.nvim_set_hl(0, "FlashLabel", {link = "DiffDelete", default = true})
      vim.keymap.set("n", "s", flash.jump, {noremap = true})
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.g.mkdp_theme = 'light'
    end
  }


}
