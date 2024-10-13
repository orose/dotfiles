return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 60,
			},
		})
		vim.keymap.set("n", "<leader>f", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree" })
	end,
}

-- vim: ts=2 sts=2 sw=2 et
