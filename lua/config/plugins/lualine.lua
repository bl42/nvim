return {
	'nvim-lualine/lualine.nvim',
    dependencies = {
		'yamatsum/nvim-nonicons',
		requires = {'kyazdani42/nvim-web-devicons'}
	},
	config = function ()
		local icons = require("nvim-nonicons")
		local nonicons_extention = require("nvim-nonicons.extentions.lualine")

		require('lualine').setup({
			sections = {
				lualine_a = { nonicons_extention.mode },
				lualine_z = {
				  {
					"branch",
					icon = icons.get("git-branch"),
				  },
				},
			  },

			options = {
				section_separators = { left = ' ', right = ' '},
				theme = "catppuccin"
			}
		})

	end

}
