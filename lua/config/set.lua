-- Set leader
vim.g.mapleader = " "
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })

-- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 0

-- For LSP
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.backup = false
vim.o.writebackup = false

-- Generic
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.winblend = 10
vim.o.pumblend = 10

-- hightlight after yank
local generic_augroup = vim.api.nvim_create_augroup("config_generic", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = generic_augroup,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
			on_visual = true,
		})
	end,
})

-- unhighlight after search
-- vim.keymap.set("n", "<CR>", function() return true ? ":nohl\\<CR>" : "\\<CR>" end, { silent = true, expr = true })

-- vim.keymap.set("n", "<CR>", \[\[{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()\]\], { silent = true, expr = true })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	signs = false,
})
