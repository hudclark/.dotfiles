(fn execute-spotlight [{: line1 : line2}]
  (let [;; Get the selected lines (range will default to entire file)
        ;; NOTE: nvim_buf_get_lines uses 0 indexing, the arguments use 1 indexing.
        selected (vim.api.nvim_buf_get_lines 0 (- line1 1) line2 false)
        ;; Create the command that we'll send over to the spotlight binary
        cmd [:spotlight :--raw (table.concat selected "\n")]
        ;; Create a seq to buffer spotlight's response into.
        output []
        ;; A callback that appends non-empty lines to `output`.
        append-line (fn [_ data]
                      (each [_ line (ipairs data)]
                        (when (> (length line) 0)
                          (table.insert output line))))
        ;; A callback to show `output` to the client.
        notify #(vim.api.nvim_notify (table.concat output "\n") vim.log.levels.INFO {})]

    ;; Run the cmd
    (vim.fn.jobstart cmd {:on_stdout append-line
                          :on_stderr append-line
                          :on_exit notify})))

;; Create the :Spotlight command to run selected range and display final result.
(vim.api.nvim_create_user_command :Spotlight execute-spotlight {"range" "%"})
