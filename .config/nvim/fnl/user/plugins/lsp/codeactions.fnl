;; Inspiration from: https://github.com/kosayoda/nvim-lightbulb/blob/master/lua/nvim-lightbulb/init.lua
(fn find [predicate seq]
  "Returns the first element that matches pred, nil otherwise"
  (var result false)
  (each [_ value (pairs seq) &until result]
    (set result (predicate value)))
  (or result nil))

(fn set-code-action-sign [line bufnr]
  "Set the buffer's code action sign to line, or remove if nil"
  (let [old vim.b.code-action-sign
	group :code-action-sign]
    (when (not= old line)
      ;; Remove old sign, if it was set
      (when old
        (vim.fn.sign_unplace group {:id old : bufnr}))
      ;; Add new sign, if it is set.
      (when line
	(vim.fn.sign_place line group :DiagnosticSignHint bufnr {:lnum line}))
      ;; Store the current sign for this buffer.
      (tset vim.b :code-action-sign line))))

(fn supports-code-actions []
  "Returns true if the buffer has any clients which support textDocument/codeAction"
  (find (fn [client]
	  (client.supports_method :textDocument/codeAction))
        (vim.lsp.buf_get_clients)))

(fn filter-result [result]
  "Decide which code-action results are worthy of a lightbulb"
  ;;(print (.. "Filtering " result.title))
  (and (not (result.title:find "^Create companion object"))
       (not (result.title:find "^Rewrite .* to braces"))))

(fn add-code-actions []
  "Checks the current line for available code actions, adding a sign if found"
  (let [diagnostics (vim.lsp.diagnostic.get_line_diagnostics)
        params (vim.lsp.util.make_range_params)
	bufnr (vim.api.nvim_get_current_buf)
	line (+ 1 params.range.start.line)]
    (tset params :context {: diagnostics})
    (vim.lsp.buf_request_all 0 :textDocument/codeAction params
			 (fn [responses]
			   (local filter-results (partial find filter-result))
			   (set-code-action-sign 
			     (find #(-?> $1
				      ;; Get the results from each response
				      (. :result)
				      ;; Filter each result
				      (filter-results)
				      ;; If we found a code action to display, return the line number
				      (and line)) responses)
			     bufnr)))))

(vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
			     {:pattern :*
			      :callback #(when (supports-code-actions) (add-code-actions))})
