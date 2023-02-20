(require :user.plugins.lsp.codeactions)
(require :user.plugins.lsp.metals)

(local lspconfig (require :lspconfig))

;; General
;; Disable underline for diagnostics. We already have signs and virtual text

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

;; Golang
(lspconfig.gopls.setup {})

;; Java

(fn start-jdtls []
  (let [jdtls (require :jdtls)
	setup (require :jdtls.setup)
	root-files (vim.fs.find ["gradlew"] {:upward true})
	root-dir (vim.fs.dirname (. root-files 1))
	data-dir :/home/hudson/jdtls-data
	cmd [:java
	     "-Declipse.application=org.eclipse.jdt.ls.core.id1"
	     "-Declipse.application=org.eclipse.jdt.ls.core.id1"
	     "-Dosgi.bundles.defaultStartLevel=4"
	     "-Declipse.product=org.eclipse.jdt.ls.core.product"
	     "-Dlog.protocol=true"
	     "-Dlog.level=ALL"
	     "-Xms1g"
	     "--add-modules=ALL-SYSTEM"
	     "--add-opens"
	     "java.base/java.util=ALL-UNNAMED"
	     "--add-opens"
	     "java.base/java.lang=ALL-UNNAMED"
	     "-jar"
	     "/home/hudson/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
	     "-configuration"
	     "/home/hudson/jdtls/config_linux"
	     "-data"
	     data-dir]]
    (print (.. "Starting jdtls @ " root-dir))
    (setup.add_commands)
    (jdtls.start_or_attach {:cmd cmd
			    :root_dir root-dir
			    :settings
			      {:java {:configuration {:runtimes [{:name :JavaSE-11 :path "/usr/lib/jvm/java-11-openjdk-amd64"}]}
			              :import {:gradle {:home "/usr/lib/jvm/java-11-openjdk-amd64"}}}}})))


;; Set up trigger to start jdtls
(local jdtls-group
       (vim.api.nvim_create_augroup :jdtls {:clear true}))

;;(vim.api.nvim_create_autocmd :FileType
                             ;;{:pattern [:java]
			      ;;:group jdtls-group
                              ;;:callback #(start-jdtls)})

;; Format on save
(vim.api.nvim_create_autocmd :BufWritePre {:command "lua vim.lsp.buf.format()"})

;; Gutter Symbols
(fn lsp-symbol [name icon]
  (vim.fn.sign_define (.. :DiagnosticSign name)
		      {:text icon
		       :numhl ""
		       :texthl (.. :DiagnosticSign name)}))
(lsp-symbol :Error :)
(lsp-symbol :Information :)
(lsp-symbol :Hint :💡)
(lsp-symbol :Info :💡)
(lsp-symbol :Warn :)


