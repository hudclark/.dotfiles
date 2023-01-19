(local lualine (require :lualine))



;; LSP status function
;; Inspired by: https://github.com/j-hui/fidget.nvim/commit/e87666ce9420da887eff4e56430317a0acd8ad5e
;;(local lualine-lsp-status
;;     (let [old-handler (. vim.lsp.handlers "$/progress")]
;;       ;; A LSP status message that has not yet been displayed.
;;       (var last-update nil)
;;       ;; A handler that sets the pending-lsp-status
;;       (fn lualine-handler [_ msg info]
;;         (print info.client_id)
;;         (set last-update msg))

;;       ;; Set the new $/progress handler
;;       (tset vim.lsp.handlers "$/progress" (if old-handler
;;                                               (fn [...]
;;                                                 (old-handler ...)
;;                                                 (lualine-handler ...))
;;                                               lualine-handler))


;;       ;; Return a function that reads from pending-lsp-status
;;       (fn []
;;         (match (-?> last-update (. :value))
;;           {:kind :begin : title} (.. "[" last-update.token "] " title)
;;           {:kind :report : message} (.. "[" last-update.token "] " message)
;;           {:kind :end} (let [token last-update.token]
;;                          (set last-update nil)
;;                          (.. "[" token "] Done"))
;;           _ ""))))

(lualine.setup {:options {:icons_enabled true
                          :theme :auto
                          :component_separators {:left "" :right ""}
                          :section_separators {:left "" :right ""}
                          :always_divide_middle true
                          :globalstatus: false
                          :refresh {:statusline 1000
                                    :tabline 1000
                                    :winbar 1000}}
                :sections {:lualine_a [:mode]
                           :lualine_b [:branch :diff: :diagnostics]
                           ;;:lualine_c [:filename lualine-lsp-status]
                           :lualine_c [:filename]
                           :lualine_x [:filetype]
                           :lualine_y [:progress]
                           :lualine_z [:location]}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [:filename]
                                    :lualine_x [:location]
                                    :lualine_y []
                                    :lualine_z []}})

