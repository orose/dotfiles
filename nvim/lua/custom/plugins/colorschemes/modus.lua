return {
	"miikanissi/modus-themes.nvim",
	name = "modus",
	dark_colorscheme = "modus_vivendi",
	light_colorscheme = "modus_operandi",
	config = function()
		require("modus-themes").setup({
			variants = {
				modus_operandi = "tinted",
				modus_vivendi = "tinted",
			},
			transparent = true,
			styles = {
				functions = { italic = true }, -- Enable italics for functions
			},
			on_colors = function(colors)
				colors.error = colors.red_faint -- Change error color to the "faint" variant
			end,
			on_highlights = function(highlight, color)
				highlight.Boolean = { fg = color.green } -- Change Boolean highlight to use the green color
			end,
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
