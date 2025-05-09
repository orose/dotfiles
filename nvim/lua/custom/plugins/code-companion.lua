return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			-- Change the default chat adapter
			chat = {
				adapter = "copilot",
			},
		},
		opts = {
			language = "Norwegian", -- Set the language for the chat
			-- Set debug logging
			log_level = "DEBUG",
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
