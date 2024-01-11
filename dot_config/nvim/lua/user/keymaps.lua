local mappings = {
                 {"i", "jj", "<Esc>"},
                 -- Normal motion works across line breaks
                 {"n", "j", "gj"},
                 {"n", "k", "gk"},
                 -- Better search under cursor
                 {"n", "*", [[*``]]},
                 -- Easier splits
                 {"n", "<C-J>", "<C-W><C-J>"},
                 {"n", "<C-K>", "<C-W><C-K>"},
                 {"n", "<C-L>", "<C-W><C-L>"},
                 {"n", "<C-H>", "<C-W><C-H>"},
                 {"n", "_", ":sp<return>"}
 }

for _, mapping in ipairs(mappings) do
	  vim.keymap.set(mapping[1], mapping[2], mapping[3], {noremap = true})
end
