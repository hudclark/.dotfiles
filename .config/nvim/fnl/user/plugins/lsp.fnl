(local lspconfig (require :lspconfig))

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
(lsp-symbol :Warning :)


;; Code Actions
;; Inspiration from: https://github.com/kosayoda/nvim-lightbulb/blob/master/lua/nvim-lightbulb/init.lua
(fn set-code-action-sign [line bufnr]
  "Set the buffer's code action sign to line, or remove if nil"
  (let [old vim.b.code-action-sign]
    (when (not= old line)
      ;; Remove old sign, if it was set
      (when old
        (vim.fn.sign_unplace :code-action-sign {:id old : bufnr}))
      ;; Add new sign, if it is set
      (when line
	(vim.fn.sign_place line :code-action-sign :DiagnosticSignHint bufnr {:lnum line}))
      (tset vim.b :code-action-sign line))))

(fn supports-code-actions []
  "Returns true if the buffer has any clients which support textDocument/codeAction"
  (var supported false)
  (each [_ client (ipairs (vim.lsp.buf_get_clients)) &until supported]
    (set supported (client.supports_method :textDocument/codeAction)))
  supported)

(fn check-code-actions []
  "Checks the current line for available code actions, adding a sign if found"
  (let [diagnostics (vim.lsp.diagnostic.get_line_diagnostics)
        params (vim.lsp.util.make_range_params)
	bufnr (vim.api.nvim_get_current_buf)
	line (+ 1 params.range.start.line)]
    (tset params :context {: diagnostics})
    (vim.lsp.buf_request 0 :textDocument/codeAction params
			 (fn [_ actions ]
			   (if actions
			       (set-code-action-sign line bufnr)
			       (set-code-action-sign nil bufnr))))))

(vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
			     {:pattern :*
			      :callback #(when (supports-code-actions) (check-code-actions))})
;; </code actions>

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
