(local opts {;; Smaller updatetime for CursorHold & CursorHoldI
             :updatetime 300
             ;; Always show signcolumn
             :signcolumn :yes
             ;; Better display for messages
             :cmdheight 2
             :history 100
             :showbreak "↪\\ \\"
             :linebreak true
             :ignorecase true
             :smartcase true
             :incsearch true
             :hlsearch true
             :cursorline true
             :showmatch true
             :backspace "indent,eol,start"
             :number true
             :scrolloff 10
             :spell true
             ;; Disable the mouse
             :mouse ""
             :ruler true
             ;; No backup/swap
             :swapfile false
             :backup false
             :writebackup false
             :autoread true
             :termguicolors true
             :splitbelow true
             :splitright true
             :completeopt [:menuone :noinsert :noselect]})

(each [key value (pairs opts)]
  (tset vim.opt key value))

;; don't give |ins-completion-menu| messages.
(vim.opt.shortmess:append :c)

;; Use system clipboard
(vim.opt.clipboard:append :unnamedplus)

(local globals {;; Space as leader
                :mapleader " "
                :loaded_netrw 1
                :loaded_netrwPlugin 1})

(each [key value (pairs globals)]
  (tset vim.g key value))

;; Random other options

;; File config
(vim.filetype.add {:extension {:conf :dosini
                               :avsc :json
                               :schema :json
                               :grpc :javascript
                               :peg :go}})

(vim.api.nvim_create_autocmd :FileType {:pattern :go
                                        :command "setlocal sw=8"})
