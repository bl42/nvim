return {
	"numToStr/Comment.nvim",
	lazy = false,

	config = function()
		require("Comment").setup({})
		local api = require("Comment.api")

		vim.keymap.set("n", "<leader>/", api.call("toggle.linewise.current", "g@$"), { expr = true })
		vim.keymap.set("v", "<leader>/", api.call("toggle.linewise", "g@"), { expr = true })
	end,
}
