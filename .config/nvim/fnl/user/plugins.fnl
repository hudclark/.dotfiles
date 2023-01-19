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

                  ;; Telescope
                  (use :nvim-telescope/telescope.nvim
                       {:requires [:nvim-lua/plenary.nvim]})

                  ;; File viewer
                  (use :nvim-tree/nvim-tree.lua
                       {:requires [:nvim-tree/nvim-web-devicons]
                        :tag :nightly})

                  ;; LSP plugins
                  (use :neovim/nvim-lspconfig)

		  ;; status messages
                  (use :j-hui/fidget.nvim
		       {:config (fn []
                                  (let [fidget (require :fidget)]
                                    (fidget.setup {:text {:spinner :dots}})))})

                  (use :scalameta/nvim-metals
                       {:requires [:nvim-lua/plenary.nvim
                                   :mfussenegger/nvim-dap]})

                  ;; Completion
                  ;; lua copilot impl
                  (use :zbirenbaum/copilot.lua
                       {:event :VimEnter
                        :config #(vim.defer_fn #((. (require :copilot) :setup))
                                               100)})

                  ;; cmp shim for copilot
                  (use :zbirenbaum/copilot-cmp
                       {:after :copilot.lua
                        :config #((. (require :copilot_cmp) :setup))})

		  ;; luasnip
		  (use :L3MON4D3/LuaSnip)
		  (use :rafamadriz/friendly-snippets)

                  ;; cmp
                  (use :hrsh7th/nvim-cmp
                       {:requires [:hrsh7th/cmp-vsnip
                                   :hrsh7th/vim-vsnip
                                   :hrsh7th/cmp-nvim-lsp
                                   :hrsh7th/cmp-buffer
                                   :saadparwaiz1/cmp_luasnip
                                   :onsails/lspkind.nvim]})

                  ;; Treesitter
                  (use :nvim-treesitter/nvim-treesitter
                       {:run ":TSUpdate"
                        ;;:requires [:RRethy/nvim-treesitter-textsubjects]})
                        })

                  ;; GRPC
                  (use :hudclark/grpc-nvim
                       {:requires [:nvim-lua/plenary.nvim]})

                  ;; Colors, Highlighting
                  (use :ellisonleao/gruvbox.nvim
		       {:config (fn []
				  (let [gruvbox (require :gruvbox)]
				    (gruvbox.setup {:italic false :contrast :soft}))
				  (vim.cmd "colorscheme gruvbox"))})

                  ;; Lualine
                  (use :nvim-lualine/lualine.nvim
                       {:requires [:kyazdani42/nvim-web-devicons]})

                  ;; Misc
		  (use :tpope/vim-sleuth)
                  (use :tpope/vim-fugitive)

                  (use :lewis6991/gitsigns.nvim
		       {:config #((. (require :gitsigns) :setup))})


                  (use :ggandor/leap.nvim
		       {:config #((. (require :leap) :add_default_mappings))})

                  (use :ggandor/leap-ast.nvim
                       {:config (fn []
                                  (let [leap-ast (require :leap-ast)]
                                    (vim.keymap.set [:n :x :o] :<leader>t #(leap-ast.leap))))})

                  (use :kylechui/nvim-surround
                       {:config #((. (require :nvim-surround) :setup) {})})

		  ;; break formatting and make it easy to append to this
		  ))

(require :user.plugins.cmp)
(require :user.plugins.lualine)
(require :user.plugins.telescope)
(require :user.plugins.nvim-tree)
(require :user.plugins.treesitter)
(require :user.plugins.metals)
(require :user.plugins.lsp)
