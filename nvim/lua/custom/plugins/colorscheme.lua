return { -- You can easily change to a different colorscheme.
	-- "folke/tokyonight.nvim",
	-- "catppuccin/nvim",
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		require("rose-pine").setup({
			variant = "auto",
			dark_variant = "moon",
			disable_background = true,
		})

		vim.cmd("colorscheme rose-pine")

		-- Ekstra konfigurasjoner for å sikre transparens
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	end,
}

-- vim: ts=2 sts=2 sw=2 et
