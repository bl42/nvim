vim.keymap.set("n", "<leader>c", function()
	vim.api.nvim_buf_delete(0, { force = true })
end)
