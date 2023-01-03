(local packer (require :packer))

(vim.cmd "packadd packer.nvim")
(packer.startup (fn [use]
                  ;; Packer
                  (use :wbthomason/packer.nvim)

		  ;; Hotpot
		  (use :rktjmp/hotpot.nvim)

                  ;; Telescope
                  (use {1 :nvim-telescope/telescope.nvim
                        :requires [:nvim-lua/plenary.nvim]})

                  ;; File viewer
                  (use {1 :nvim-tree/nvim-tree.lua
                        :requires [:nvim-tree/nvim-web-devicons]
                        :tag :nightly})

                  ;; LSP plugins
                  (use :neovim/nvim-lspconfig)

		  ;; status messages
                  (use {1 :j-hui/fidget.nvim
		        :config #((. (require :fidget) :setup))})

                  (use {1 :scalameta/nvim-metals
                        :requires [:nvim-lua/plenary.nvim
                                   :mfussenegger/nvim-dap]})

                  ;; Completion
                  ;; lua copilot impl
                  (use {1 :zbirenbaum/copilot.lua
                        :event :VimEnter
                        :config #(vim.defer_fn #((. (require :copilot) :setup))
                                               100)})

                  ;; cmp shim for copilot
                  (use {1 :zbirenbaum/copilot-cmp
                        :after :copilot.lua
                        :config #((. (require :copilot_cmp) :setup))})

		  ;; luasnip
		  (use :L3MON4D3/LuaSnip)
		  (use :rafamadriz/friendly-snippets)

                  ;; cmp
                  (use {1 :hrsh7th/nvim-cmp
                        :requires [:hrsh7th/cmp-vsnip
                                   :hrsh7th/vim-vsnip
                                   :hrsh7th/cmp-nvim-lsp
                                   :hrsh7th/cmp-buffer
                                   :saadparwaiz1/cmp_luasnip
                                   :onsails/lspkind.nvim]})
                  ;; Treesitter
                  (use {1 :nvim-treesitter/nvim-treesitter :run ":TSUpdate"})

                  ;; GRPC
                  (use {1 :hudclark/grpc-nvim
                        :requires [:nvim-lua/plenary.nvim]})

                  ;; Colors, Highlighting
                  (use {1 :ellisonleao/gruvbox.nvim
		        :config (fn []
				  (let [gruvbox (require :gruvbox)]
				    (gruvbox.setup {:italic false :contrast :soft}))
				  (vim.cmd "colorscheme gruvbox"))})

                  ;; Lualine
                  (use {1 :nvim-lualine/lualine.nvim
                        :requires [:kyazdani42/nvim-web-devicons]})

                  ;; Misc
                  (use :tpope/vim-surround)
		  (use :tpope/vim-sleuth)
                  (use :tpope/vim-fugitive)

                  (use {1 :lewis6991/gitsigns.nvim
		        :config #((. (require :gitsigns) :setup))})


                  (use {1 :ggandor/leap.nvim
		        :config #((. (require :leap) :add_default_mappings))})

		  ;; break formatting and make it easy to append to this
		  ))

(require :user.plugins.cmp)
(require :user.plugins.lualine)
(require :user.plugins.telescope)
(require :user.plugins.nvim-tree)
(require :user.plugins.treesitter)
(require :user.plugins.metals)
(require :user.plugins.lsp)
