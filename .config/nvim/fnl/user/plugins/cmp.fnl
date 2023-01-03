(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local lspkind (require :lspkind))

;; Configure luasnip

(let [types (require :luasnip.util.types)
      loader (require :luasnip.loaders.from_vscode)]
  (luasnip.config.setup {:history true
                         :updateevents "TextChanged,TextChangedI"
                         :enable_autosnippets true
                         :ext_opts {[types.choiceNode] {:active {:virt_text [[:Choice
                                                                              :Comment]]}}}})
  (loader.lazy_load))

;; Luasnip keymaps
(vim.keymap.set :i :<C-h> #(luasnip.jump -1) {:noremap true})
(vim.keymap.set :s :<C-h> #(luasnip.jump -1) {:noremap true})
(vim.keymap.set :i :<C-l> #(luasnip.jump 1) {:noremap true})
(vim.keymap.set :s :<C-l> #(luasnip.jump 1) {:noremap true})

;; Configure CMP
(cmp.setup {:sources (cmp.config.sources [{:name :vsnip}
                                          {:name :copilot}
                                          {:name :nvim_lsp}]
                                         [{:name :buffer :keyword_length 4}])
            :window {:documentation (cmp.config.window.bordered)}
            :snippet {:expand #(luasnip.lsp_expand $1.body)}
            :mapping {:<Tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.select_next_item)
                                                  (cmp.complete)))
                                            [:i :s])
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                                (if (cmp.visible)
                                                    (cmp.select_prev_item)
                                                    (fallback)))
                                              [:i :s])
                      :<CR> (cmp.mapping.confirm {:select false
                                                    :behavior cmp.ConfirmBehavior.Replace})}
            :preselect cmp.PreselectMode.None
            :formatting {:format (lspkind.cmp_format {:mode :symbol
                                                      :maxwidth 50
                                                      :ellipsis_char "..."
                                                      :symbol_map {:Copilot ""}})}})
