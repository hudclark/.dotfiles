(local noremaps [;; Double press j to escape
                 [:i :jj :<Esc>]
                 ;; Escape from terminal mode
                 ;; [:t :<Esc> "<C-\\><C-n>"]
                 ;; Normal motion works across line breaks
                 [:n :j :gj]
                 [:n :k :gk]
                 ;; Better search under cursor
                 [:n "*" "*``"]
                 ;; Easier splits
                 [:n :<C-J> :<C-W><C-J>]
                 [:n :<C-K> :<C-W><C-K>]
                 [:n :<C-L> :<C-W><C-L>]
                 [:n :<C-H> :<C-W><C-H>]
                 [:n "_" ":sp<return>"]

                 ;; Base64 decode: Replace selected text with base64 decoded version.
                 ;; https://stackoverflow.com/a/40745410
                 [:v :<C-b> "c<c-r>=system(\"base64 -d\", @\")<cr><esc>" ]

                 ;; Break formatting
                 ])

(each [_ mapping (ipairs noremaps)]
  (match mapping
    [mode key command] (vim.keymap.set mode key command {:noremap true})
    _ (print "Invalid mapping")))
