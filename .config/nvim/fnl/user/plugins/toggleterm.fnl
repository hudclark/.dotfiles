(local toggleterm (require :toggleterm))
(local {: Terminal} (require :toggleterm.terminal))

(toggleterm.setup {:open_mapping :<c-t>
                   :shade_terminals true
                   :size 25})

;; Create a dedicated lazygit terminal
(local lazygit (Terminal:new {:cmd :lazygit
                              :dir :git_dir
                              :direction :float
                              :float_opts {:border :single}
                              :on_open (fn [term]
                                         (vim.cmd :startinsert!)
                                         (vim.api.nvim_buf_set_keymap term.bufnr :n :q :<cmd>close<CR> {:noremap true :silent true}))
                              :on_close (fn [term]
                                         (vim.cmd :startinsert!))
                              :hidden true}))

(vim.keymap.set :n :<leader>g #(lazygit:toggle) {:silent true})

;; Create a dedicated k9s terminal
(local k9s (Terminal:new {:cmd :k9s
                              :dir :git_dir
                              :direction :float
                              :float_opts {:border :single}
                              :on_open (fn [term]
                                         ;; (vim.cmd :startinsert!)
                                         (vim.api.nvim_buf_set_keymap term.bufnr :t :q :<cmd>close<CR> {:noremap true :silent true}))
                              ;;:on_close (fn [term]
                                         ;;(vim.cmd :startinsert!))
                              :hidden true}))

(vim.keymap.set :n :<leader>k #(k9s:toggle) {:silent true})
