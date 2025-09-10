return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "anthropic",
			},
			inline = {
				adapter = "anthropic",
			},
		},
		adapters = {
			http = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "ANTHROPIC_API_KEY",
						},
						schema = {
							model = {
								default = "claude-sonnet-4-20250514",
							},
						},
					})
				end,
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {})
				end,
			},
		},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)
		vim.keymap.set("n", "<Leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
		vim.keymap.set("v", "<Leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
	end,
}
-- vim: ts=2 sts=2 sw=2 et
