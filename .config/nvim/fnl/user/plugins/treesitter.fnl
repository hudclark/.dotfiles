(local ts-configs (require :nvim-treesitter.configs))
(local parsers (require :nvim-treesitter.parsers))

(local parser-config (parsers.get_parser_configs))

;; Add nushell support
(tset parser-config :nu {:install_info {:url :https://github.com/nushell/tree-sitter-nu
                                        :files [:src/parser.c]
                                        :branch :main}
                         :filetype :nu})

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

;; Support for octo
(vim.treesitter.language.register :markdown :octo)
