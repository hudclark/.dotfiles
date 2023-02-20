(local metals (require :metals))
(local metals-config (metals.bare_config))

;; This is a shim to enable metals to play nicely with other LSP status tools like Fidget.
;; https://github.com/pca006132/dotfiles/blob/master/nvim/lsp.lua#L69
(fn status-handler [err status ctx]
  (let [text (-> status.text
                 (: :gsub "[⠇⠋⠙⠸⠴⠦]" "")
                 (: :gsub "^%s*(.-)%s*$" "%1"))
        msg-val (if status.hide {:kind :end}
                    status.show {:kind :begin :title text}
                    status.text {:kind :report :message text})
        info {:client_id ctx.client_id}
        msg {:token :metals :value msg-val}]
    (when msg.value
      ((. vim.lsp.handlers :$/progress) err msg ctx))))

;; Tell metals to use the above status handler
(tset metals-config :handlers {:metals/status status-handler})

;; Enable metals LSP status
(tset metals-config.init_options :statusBarProvider :on)

(tset metals-config :settings {:showImplicitArguments true
                               :showImplicitConversionsAndClasses true
                               :showInferredType true})
(tset metals-config :capabilities
      ((. (require :cmp_nvim_lsp) :default_capabilities)))

(tset metals-config :on_attach (fn [client bufnr]
                                 (metals.setup_dap)))

;; Set up trigger to start metals
(local nvim-metals-group
       (vim.api.nvim_create_augroup :nvim-metals {:clear true}))
(vim.api.nvim_create_autocmd :FileType
                             {:pattern [:scala :sbt]
                              :callback #(metals.initialize_or_attach metals-config)
                              :group nvim-metals-group})

;; keymaps
(vim.keymap.set :n :<leader>i metals.organize_imports {:noremap true})
(vim.keymap.set :n :<leader>fm
                "<cmd>lua require'telescope'.extensions.metals.commands()<CR>"
                {:noremap true})
