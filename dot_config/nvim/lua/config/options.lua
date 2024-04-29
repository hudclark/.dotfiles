-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.mouse = ""
vim.opt.relativenumber = false
vim.opt.showbreak = " ↳ "
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.conceallevel = 0

-- Disable changing the LSP root directory
-- https://github.com/LazyVim/LazyVim/discussions/2150#discussioncomment-7787591
vim.g.root_spec = { "cwd" }
