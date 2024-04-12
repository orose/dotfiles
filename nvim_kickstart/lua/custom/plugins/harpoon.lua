return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Add file to list" })
		vim.keymap.set("n", "<leader>l", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Show list" })
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon: Goto previous file" })
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():next()
		end, { desc = "Harpoon: Goto next file" })
	end,
}
-- vim: ts=2 sts=2 sw=2 et
