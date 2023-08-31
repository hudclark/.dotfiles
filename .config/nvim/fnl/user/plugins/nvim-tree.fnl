(local nvim-tree (require :nvim-tree))

(nvim-tree.setup {:reload_on_bufenter true
		  :diagnostics {:enable true}
		  :filesystem_watchers {:enable true}
		  :update_focused_file {:enable true}
		  :view {:adaptive_size true
			 :mappings {:list [{:key :i :action :split}
					   {:key :s :action :vsplit}
					   {:key :d :action :trash}]}}
		 :renderer {:group_empty true}})

(vim.keymap.set :n "\\" :<cmd>NvimTreeToggle<CR> {:noremap true})
(vim.keymap.set :n "<c-\\>" :<cmd>NvimTreeFocus<CR> {:noremap true})
;; (vim.api.nvim_create_autocmd [:VimEnter] {:callback nvim-tree.open})
