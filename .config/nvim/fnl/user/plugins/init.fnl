(local packer (require :packer))

(vim.cmd "packadd packer.nvim")
(packer.startup (fn [use-]
                  ;; Packer mashes together sequential and map-like tables.
                  ;; This is a helper fn to make it play a little nicer in fennel
                  (fn use [plugin config]
                    (use- (if config
                              (vim.tbl_extend :error {1 plugin} config)
                              [plugin])))

                  ;; Packer
                  (use :wbthomason/packer.nvim)

		  ;; Hotpot
		  (use :rktjmp/hotpot.nvim)

                  ;; Colors, Highlighting
                  (use :ellisonleao/gruvbox.nvim
		       {:config (fn []
				  (let [gruvbox (require :gruvbox)]
				    (gruvbox.setup {:italic {:comments true
                                                             :strings false}
                                                    :palette_overrides {:neutral_red :#fb4934}
                                                    :contrast :soft}))
				  (vim.cmd "colorscheme gruvbox"))})

                  ;; Telescope
                  (use :nvim-telescope/telescope.nvim
                       {:requires [:nvim-lua/plenary.nvim]})

                  ;; File viewer
                  (use :nvim-tree/nvim-tree.lua
                       {:requires [:nvim-tree/nvim-web-devicons]
                        :tag :nightly})

                  ;; LSP plugins
                  (use :neovim/nvim-lspconfig)
                  (use :mfussenegger/nvim-jdtls)
                  (use :mfussenegger/nvim-dap)
                  (use :rcarriga/nvim-dap-ui)

		  ;; status messages
                  (use :j-hui/fidget.nvim
		       {:config (fn []
                                  (let [fidget (require :fidget)]
                                    ; (fidget.setup {:text {:spinner :dots}})))})
                                    (fidget.setup {})))})

                  (use :scalameta/nvim-metals
                       {:requires [:nvim-lua/plenary.nvim
                                   :mfussenegger/nvim-dap]})

                  ;; Completion
                  ;; lua copilot impl
                  (use :zbirenbaum/copilot.lua
                       {;;:event :InsertEnter
                        :config (fn []
                                  (let [copilot (require :copilot)
                                        suggestion (require :copilot.suggestion)
                                        cmp (require :cmp)]
                                    (copilot.setup {:suggestion {:enabled true
                                                                 :auto_trigger true
                                                                 :accept false}
                                                    :panel {:enabled false}})

                                    ;; tab completion is set up in cmp.fnl
                                    ;; <TAB> will take the copilot suggestion
                                    ;; <S-TAB> will cycle through the copilot suggestions

                                    ;; We also set up taking suggestions a line at a time here.
                                    ;; (vim.keymap.set :i :<S-CR> suggestion.accept_line)

                                    ;; hide copilot when cmp is open
                                    (cmp.event:on :menu_opened #(tset vim.b :copilot_suggestion_hidden true))
                                    (cmp.event:on :menu_closed #(tset vim.b :copilot_suggestion_hidden false))

                                    ))})

                  (use :folke/trouble.nvim)

                  ;; cmp shim for copilot
                  ;;(use :zbirenbaum/copilot-cmp
                       ;;{:after :copilot.lua
                        ;;:config (fn []
                                  ;;(let copilot_cmp (require :copilot_cmp)
                                    ;;(copilot_cmp.setup {})))})


                  ;; cmp
                  (use :hrsh7th/nvim-cmp
                       {:requires [:hrsh7th/cmp-vsnip
                                   :hrsh7th/vim-vsnip
                                   :hrsh7th/cmp-nvim-lsp
                                   :hrsh7th/cmp-buffer
                                   :onsails/lspkind.nvim]})

                  ;; Treesitter
                  (use :nvim-treesitter/nvim-treesitter
                       {:run ":TSUpdate"
                        ;;:requires [:RRethy/nvim-treesitter-textsubjects]})
                        })

                  ;; GRPC
                  (use :hudclark/grpc-nvim
                       {:requires [:nvim-lua/plenary.nvim]})

                  ;; Lualine
                  (use :nvim-lualine/lualine.nvim
                       {:requires [:kyazdani42/nvim-web-devicons]})

                  ;; Misc
		  (use :tpope/vim-sleuth)
                  (use :tpope/vim-fugitive)

                  (use :lewis6991/gitsigns.nvim
		       {:config #((. (require :gitsigns) :setup))})


                  (use :folke/flash.nvim
		       {:config (fn []
                                  (let [flash (require :flash)]
                                    (flash.setup {:label {:before true :after false}
                                                  :modes {:search {:enabled false}
                                                          :char {:jump_labels true}}})
                                    ;; turn off flash for regular search
                                    (vim.api.nvim_set_hl 0 :FlashLabel {:link :DiffDelete :default true})
                                    (vim.keymap.set :n :s flash.jump {:noremap true})
                                    (vim.keymap.set :o :r flash.remote {:noremap true})))})

                  (use :kylechui/nvim-surround
                       {:config #((. (require :nvim-surround) :setup) {})})


                  (use :ellisonleao/glow.nvim
                       {:config (fn []
                                  (let [glow (require :glow)]
                                    (glow.setup {})))})

                  (use :ray-x/go.nvim
                       {:requires [:ray-x/guihua.lua]
                        :config (fn []
                                  (let [go (require :go)]
                                    (go.setup {})))})

                  (use :akinsho/toggleterm.nvim)

		  ;; break formatting and make it easy to append to this
		  ))

(require :user.plugins.cmp)
(require :user.plugins.lualine)
(require :user.plugins.telescope)
(require :user.plugins.nvim-tree)
(require :user.plugins.treesitter)
(require :user.plugins.lsp)
(require :user.plugins.toggleterm)
(require :user.plugins.trouble)
