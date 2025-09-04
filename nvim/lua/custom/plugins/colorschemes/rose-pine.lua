return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "auto",
			dark_variant = "moon",
			disable_background = true,
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
