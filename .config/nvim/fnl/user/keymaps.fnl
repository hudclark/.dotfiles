(local noremaps [;; Double press j to escape
                 [:i :jj :<Esc>]
                 ;; Escape from terminal mode
                 [:t :<Esc> "<C-\\><C-n>"]
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
                 [:n "_" ":sp<return>"]])

(each [_ mapping (ipairs noremaps)]
  (match mapping
    [mode key command] (vim.keymap.set mode key command {:noremap true})
    _ (print "Invalid mapping")))
