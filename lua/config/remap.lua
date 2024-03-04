vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line down" })

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank current selected text to the clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank current line to the clipboard" })

vim.keymap.set("n", "<leader>c", function()
	vim.api.nvim_buf_delete(0, { force = true })
end, { desc = "[c]lose current buff" })
