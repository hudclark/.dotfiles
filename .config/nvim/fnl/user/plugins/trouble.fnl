(local trouble (require :trouble))

(vim.keymap.set :n :<leader>xx trouble.open)
(vim.keymap.set :n :<leader>xw #(trouble.open :workspace_diagnostics))
(vim.keymap.set :n :<leader>xd #(trouble.open :document_diagnostics))
(vim.keymap.set :n :<leader>xq #(trouble.open :quickfix))
(vim.keymap.set :n :<leader>xl #(trouble.open :loclist))
