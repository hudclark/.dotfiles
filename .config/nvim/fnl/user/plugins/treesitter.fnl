(local ts-configs (require :nvim-treesitter.configs))

(ts-configs.setup {:sync_install false
                   :auto_install true
                   :highlight {:enable true
                               :addititional_vim_regex_highlighting false}

                   :incremental_selection {:enable true
                                           :keymaps {:init_selection :<CR>
                                                     :scope_incremental :<CR>
                                                     :node_incremental :<Tab>
                                                     :node_decremental :<S-Tab>}}})
