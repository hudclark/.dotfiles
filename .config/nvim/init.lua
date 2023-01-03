vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'j-hui/fidget.nvim'
   
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'hudclark/grpc-nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'derekwyatt/vim-scala'
  use 'tpope/vim-surround'

  -- use 'morhetz/gruvbox'
  use { "ellisonleao/gruvbox.nvim" }

  use {'junegunn/fzf', run = ':call fzf#install()' }
  use 'lewis6991/gitsigns.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'stephpy/vim-yaml'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'ggandor/leap.nvim'

  use {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  }

  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",
    },
  })

  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })


  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'simrat39/symbols-outline.nvim'

  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }

end)

-- Space as leader
vim.g.mapleader = ' '

-- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.updatetime = 300

-- don't give |ins-completion-menu| messages.
vim.opt.shortmess:append('c')

-- always show signcolumns
vim.opt.signcolumn = 'yes'

-- Better display for messages
vim.opt.cmdheight = 2

-- Some general config
vim.opthistory = 100
vim.opt.showbreak = '↪\\ \\'
vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.backspace = 'indent,eol,start'
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.spell = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable the mouse
vim.opt.mouse= ""
vim.opt.ruler = true

-- No backup/swap
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autoread = true

-- Double press j to escape
vim.keymap.set('i', 'jj', '<Esc>')

-- Escape easily from terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Normal motion works on line breaks
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

-- Better search under cursor
vim.keymap.set('n', '*', '*``', { noremap = true })

-- Init Leap
require('leap').add_default_mappings()

-- Init git signs
require('gitsigns').setup()

-- Theme
vim.opt.termguicolors = true

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- Telescope config
require('telescope').setup({
  defaults = {
    path_display = { 'truncate' }
  }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {noremap = true})
vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})

-- Easier splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', {noremap = true})
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', {noremap = true})
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', {noremap = true})
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', {noremap = true})
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set('n', '_', ':sp<return>', {noremap = true})

-- File config
vim.filetype.add({
  extension = {
    conf = 'dosini',
    avsc = 'json',
    schema = 'json',
    proto = 'proto',
    peg = 'go'
  }
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  command = "setlocal ts=2 sw=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  command = "setlocal ts=4 sw=4 sts=0 noexpandtab"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal ts=4 sw=4 sts=4"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  command = "setlocal ts=2 sw=2 sts=2"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "proto",
  command = "setlocal ts=2 sw=2 sts=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  command = "setlocal ts=2 sw=2 sts=2 expandtab"
})


-- lsp mappings
-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {noremap = true})
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true})
vim.keymap.set("n", "gr", builtin.lsp_references, {noremap = true})
-- vim.keymap.set("n", "<leader>o", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>o", builtin.lsp_document_symbols, {noremap = true})

-- organize imports
vim.keymap.set("n", "<leader>i", [[<cmd>lua require("metals").organize_imports()<CR>]], {noremap = true})

vim.keymap.set("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]], {noremap = true})
vim.keymap.set("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], {noremap = true})
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>', {noremap = true})
vim.keymap.set("n", "<leader>fm", '<cmd>lua require"telescope".extensions.metals.commands()<CR>', {noremap = true})
-- vim.keymap.set("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]], {noremap = true})
vim.keymap.set("n", "<leader>a", builtin.diagnostics, {noremap = true})

vim.keymap.set("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]], {noremap = true})
vim.keymap.set("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]], {noremap = true})

-- open full diagnostic under current line
vim.keymap.set("n", "<leader>ld", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>]], {noremap = true})

vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
vim.keymap.set("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>", {noremap = true})
vim.keymap.set("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>", {noremap = true})

-- completion related settings
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

-- ctrl-k to trigger LSP completion
vim.keymap.set("i", "<c-k>", [[<cmd>lua require("cmp").complete()<CR>]], {noremap = true})

-- signature help
vim.keymap.set("i", "<c-s>", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], {noremap = true})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

luasnip.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [require("luasnip.util.types").choiceNode] = {
      active = {
        virt_text = { { "Choice", "Comment" } },
      },
    },
  },
})
vim.keymap.set("i", "<c-h>", [[<cmd>lua require('luasnip').jump(-1)<CR>]], {noremap = true})
vim.keymap.set("s", "<c-h>", [[<cmd>lua require('luasnip').jump(-1)<CR>]], {noremap = true})
vim.keymap.set("i", "<c-l>", [[<cmd>lua require('luasnip').jump(1)<CR>]], {noremap = true})
vim.keymap.set("s", "<c-l>", [[<cmd>lua require('luasnip').jump(1)<CR>]], {noremap = true})

require("luasnip.loaders.from_vscode").lazy_load()

local lspkind = require('lspkind')
local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = 'vsnip' },
    { name = "copilot" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer", keyword_length = 4 },
  }),
  window = {
    documentation = cmp.config.window.bordered()
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      --elseif luasnip.expand_or_jumpable() then
        --luasnip.expand_or_jump()
      elseif has_words_before() then
         cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      --elseif luasnip.jumpable(-1) then
        --luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
      --["<CR>"] = cmp.mapping.confirm({
        -- this is the important line
        --behavior = cmp.ConfirmBehavior.Replace,
        --select = false,
      --})
  },
  preselect = cmp.PreselectMode.None,
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      symbol_map = { Copilot = "" },
    })
  },
})

local metals_config = require("metals").bare_config()

-- https://github.com/pca006132/dotfiles/blob/master/nvim/lsp.lua#L69
local function metals_status_handler(err, status, ctx)
  local val = {}
  -- trim and remove spinner
  local text = status.text:gsub('[⠇⠋⠙⠸⠴⠦]', ''):gsub("^%s*(.-)%s*$", "%1")
  if status.hide then
    val = {kind = "end"}
  elseif status.show then
    val = {kind = "begin", title = text}
  elseif status.text then
    val = {kind = "report", message = text}
  else
    return
  end
  local info = {client_id = ctx.client_id}
  local msg = {token = "metals", value = val}
  vim.lsp.handlers["$/progress"](err, msg, ctx)
end
metals_config.handlers = { ['metals/status'] = metals_status_handler }

-- Default args
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}


-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.format()" })

-- Statusline
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { 'filename' },
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  -- ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Fileviewer setup
require("nvim-tree").setup {
  open_on_setup = true,
  diagnostics = {
    enable = true
  },
  filesystem_watchers = {
    enable = true
  },
  update_focused_file = {
    enable = true
  },
  view = {
    adaptive_size = true,
    signcolumn = "no",
    mappings = {
      list = {
        { key = "i", action = "split" },
        { key = "s", action = "vsplit" },
        { key = "d", action = "trash" },
      }
    }
  },
  renderer = {
    group_empty = true,
  },
}
vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", {noremap = true})
vim.keymap.set("n", "<c-\\>", "<cmd>NvimTreeFocus<CR>", {noremap = true})

-- Golang config
require'lspconfig'.gopls.setup{}

-- LSP status messages
require"fidget".setup{}

require("symbols-outline").setup()
