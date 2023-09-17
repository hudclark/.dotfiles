(local cmp (require :cmp))
(local lspkind (require :lspkind))
(local copilot-suggestion (require :copilot.suggestion))

;; Configure CMP
(cmp.setup {:sources (cmp.config.sources [;;{:name :copilot}
                                          {:name :nvim_lsp}])
                                         ;;[{:name :buffer :keyword_length 4}])
            ;; :window {:documentation (cmp.config.window.bordered)}
            :snippet {:expand (fn [args] ((. vim.fn "vsnip#anonymous") args.body))}
            :mapping {:<Tab> (cmp.mapping (fn [fallback]
                                              (if (copilot-suggestion.is_visible)
                                                  (copilot-suggestion.accept)
                                                  (cmp.visible)
                                                  (cmp.select_next_item)
                                                  (cmp.complete)))
                                            [:i :s])
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                                (if (copilot-suggestion.is_visible)
                                                    (copilot-suggestion.next)
                                                    (cmp.visible)
                                                    (cmp.select_prev_item)
                                                    (fallback)))
                                              [:i :s])
                      :<CR> (cmp.mapping.confirm {:select false
                                                    :behavior cmp.ConfirmBehavior.Replace})}
            :preselect cmp.PreselectMode.None
            :formatting {:format (lspkind.cmp_format {:mode :symbol
                                                    ;;:maxwidth 50
                                                    :ellipsis_char "..."
                                                    :symbol_map {:Copilot ""}})}})
