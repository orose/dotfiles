return {
	"epwalsh/obsidian.nvim",
	version = "*",
	-- lazy = true,
	-- ft = "markdown",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("obsidian").setup({
			workspaces = { {
				name = "Skatteetaten",
				path = "~/OneDrive - Skatteetaten/Notater",
			} },
			note_id_func = function(title)
				local sanitized_title = title:gsub("[^A-Za-z0-9]", "_"):lower()
				return sanitized_title
			end,
			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url })
			end,
		})

		vim.api.nvim_set_keymap("n", "<leader>ob", ":vsplit | ObsidianSearch<CR>", { noremap = true, silent = true })
	end,
}

-- vim: ts=2 sts=2 sw=2 et
