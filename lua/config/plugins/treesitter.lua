-- Treesitter parsers provided by NixOS (withAllGrammars)
-- This file just ensures highlighting is enabled

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

return {}
