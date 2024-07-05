-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Override the shell used by floating terminal
local lazyterm = function()
  LazyVim.terminal("/usr/bin/nu", { cwd = LazyVim.root() })
end
vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })

-- Disable moving windows when there is a floating term
vim.keymap.del("t", "<C-h>")
vim.keymap.del("t", "<C-j>")
vim.keymap.del("t", "<C-k>")
vim.keymap.del("t", "<C-l>")
