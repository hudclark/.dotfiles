(local telescope (require :telescope))
(local builtin (require :telescope.builtin))

(telescope.setup {:defaults {:path_display [:truncate]}})

(vim.keymap.set :n :<C-p> builtin.find_files {:noremap true})
(vim.keymap.set :n :<leader>ff builtin.live_grep)
(vim.keymap.set :n :<leader>fh builtin.help_tags)
(vim.keymap.set :n :<leader>fr builtin.oldfiles)
(vim.keymap.set :n :<leader>a builtin.diagnostics {:noremap true})
(vim.keymap.set :n :gd builtin.lsp_definitions {:noremap true})
(vim.keymap.set :n :gr builtin.lsp_references {:noremap true})
(vim.keymap.set :n :<leader>o builtin.lsp_document_symbols {:noremap true})
