(local lspconfig (require :lspconfig))

;; Golang
(lspconfig.gopls.setup {})

;; Format on save
(vim.api.nvim_create_autocmd :BufWritePre {:command "lua vim.lsp.buf.format()"})

;; Keymaps
(local mappings [[:n :K "<cmd>lua vim.lsp.buf.hover()<CR>"]
		 ;; Not using this as I prefer to use gr and use gi for going to
		 ;; last insert
		 ;;[:n :gi "<cmd>lua vim.lsp.buf.implementation()<CR>"]
		 [:n :<leader>rn "<cmd>lua vim.lsp.buf.rename()<CR>"]
		 [:n :<leader>ca "<cmd>lua vim.lsp.buf.code_action()<CR>"]
		 [:n :<leader>ld "<cmd>lua vim.diagnostic.open_float(0, {scope = \"line\"})<CR>"]
		 ;; ctrl-k to trigger LSP completion
		 ;; vim.keymap.set("i", "<c-k>", [[<cmd>lua require("cmp").complete()<CR>]], {noremap = true})
	         ;; signature help
		 [:i :<C-s> "<cmd>lua vim.lsp.buf.signature_help()<CR>"]])

(each [_ mapping (ipairs mappings)]
  (match mapping
    [mode key command] (vim.keymap.set mode key command {:noremap true})
    _ (print (.. "Invalid mapping: " (vim.inspect mapping)))))
