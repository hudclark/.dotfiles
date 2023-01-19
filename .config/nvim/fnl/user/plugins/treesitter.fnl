(local ts-configs (require :nvim-treesitter.configs))

(ts-configs.setup {:sync_install false
                   :auto_install true
                   :highlight {:enable true
                               :addititional_vim_regex_highlighting false}

                   ;; RRethy/nvim-treesitter-textsubjects
                   :textsubjects {:enable false
                                  :prev_selection ","
                                  :keymaps {"." :textsubjects-smart
                                            ";" :textsubjects-container-outer
                                            "i;" :textsubjects-container-inner}}})
