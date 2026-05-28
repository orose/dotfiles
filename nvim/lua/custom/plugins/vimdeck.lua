return {
	"ducks/vimdeck.nvim",
	cmd = { "Vimdeck", "VimdeckFile" },
	config = function()
		require("vimdeck").setup({
			use_figlet = false,
			header_style = "underline",
			center_vertical = true,
			center_horizontal = true,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "vimdeck",
			callback = function()
				vim.defer_fn(function()
					vim.opt_local.list = false
				end, 100)
			end,
		})
	end,
}
-- vim: ts=2 sts=2 sw=2 et
