-- Options
local opt = vim.opt

opt.updatetime = 300
opt.signcolumn = "yes"
opt.cmdheight = 2
opt.history = 100
opt.showbreak = "↳ "
opt.linebreak = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.cursorline = true
opt.showmatch = true
opt.backspace = "indent,eol,start"
opt.number = true
opt.scrolloff = 10
opt.spell = true
opt.mouse = ""
opt.ruler = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.completeopt = "menuone,noinsert,noselect"
opt.clipboard = "unnamedplus"

-- Globals
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- File config
vim.filetype.add({
  extension = {
    conf = "dosini",
    avsc = "json",
    schema = "json",
    grpc = "javascript",
    peg = "go"
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setlocal sw=8"
})
