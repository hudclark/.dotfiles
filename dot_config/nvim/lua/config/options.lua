-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Disable mouse support
vim.opt.mouse = ""
-- vim.opt.relativenumber = false
-- Configure the string to display when lines break
vim.opt.showbreak = " ↳ "
-- Enable line break at convenient points
vim.opt.linebreak = true
-- Enable line wrapping for long lines
vim.opt.wrap = true
-- Set conceal level to 0, showing all concealed text
vim.opt.conceallevel = 0
-- Enable spell checking
vim.opt.spell = true
-- Use the system clipboard for unnamed registers
vim.opt.clipboard = "unnamedplus"

-- Disable changing the LSP root directory
-- https://github.com/LazyVim/LazyVim/discussions/2150#discussioncomment-7787591
vim.g.root_spec = { "cwd" }

-- Use bash for neotest stuff. It doesn't like nushell
-- Set the shell for Neotest to Nushell
vim.o.shell = "nu"

-- no animations
vim.g.snacks_animate = false
