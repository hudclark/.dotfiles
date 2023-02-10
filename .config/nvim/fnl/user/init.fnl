(require :user.keymaps)
(require :user.options)
(require :user.plugins)
(require :user.events)
(require :user.spotlight)

;; TODO: Remove
(let [repl (require :user.repl)]
  (repl.setup))
