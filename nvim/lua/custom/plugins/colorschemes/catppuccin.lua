return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			float = {
				background = true,
				transparent = true,
				solid = true,
				blend = 0,
			},
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
