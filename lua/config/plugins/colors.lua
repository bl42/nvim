return {
  "catppuccin/nvim",
   config = function()
      require('catppuccin').setup({
          disable_background = true,
      })

      vim.cmd("colorscheme catppuccin")
  end
}
