return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigasjon mellom hunks
			map("n", "]h", function()
				gs.nav_hunk("next")
			end, "Neste hunk")
			map("n", "[h", function()
				gs.nav_hunk("prev")
			end, "Forrige hunk")

			-- Se hva som er endret
			map("n", "<leader>hp", gs.preview_hunk, "Forhåndsvis hunk")
			map("n", "<leader>hi", gs.preview_hunk_inline, "Hunk inline")
			map("n", "<leader>hd", gs.diffthis, "Diff mot indeks")
			map("n", "<leader>hD", function()
				gs.diffthis("HEAD")
			end, "Diff mot HEAD")
			map("n", "<leader>tw", gs.toggle_word_diff, "Toggle word diff")

			-- Nyttig i tillegg
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Blame linje")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
