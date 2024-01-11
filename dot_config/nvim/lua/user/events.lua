-- Set the cursor to the last known location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("bufcheck", {}),
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank({higroup = "IncSearch", timeout = 200})
  end
})
