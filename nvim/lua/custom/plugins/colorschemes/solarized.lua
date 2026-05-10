return {
	"maxmx03/solarized.nvim",
	name = "solarized",
	dark_colorscheme = "solarized",
	light_colorscheme = "solarized",
	config = function()
		require("solarized").setup({})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
