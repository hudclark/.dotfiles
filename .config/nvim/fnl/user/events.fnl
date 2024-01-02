;; Set the cursor to the last known location when opening a buffer.
;(vim.api.nvim_create_autocmd :BufReadPost
;                            {:group (vim.api.nvim_create_augroup :bufcheck {})
;                             :pattern :*
;                             :callback (fn []
;                                         (when (and
;                                               (> (vim.fn.line "'\"") 0)
;                                               (<= (vim.fn.line "'\"") (vim.fn.line "$")))
;                                           (vim.fn.setpos "." (vim.fn.getpos "'\""))
;                                           (vim.api.nvim_feedkeys :zz :n true)))})


;; Highlight yanked text
(vim.api.nvim_create_autocmd :TextYankPost
                             {:group (vim.api.nvim_create_augroup :yank_highlight {})
                              :pattern :*
                              :callback (fn []
                                          (vim.highlight.on_yank {:higroup :IncSearch}))})
