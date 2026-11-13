return {
	"sainnhe/gruvbox-material",
	name = "gruvbox-material",
	-- Samme colorscheme for begge; varianten styres av vim.o.background (settes av auto-dark-mode)
	dark_colorscheme = "gruvbox-material",
	light_colorscheme = "gruvbox-material",
	config = function()
		-- Vimscript-tema: konfigureres via globale variabler før colorscheme lastes
		vim.g.gruvbox_material_background = "medium" -- "hard", "medium" eller "soft"
		vim.g.gruvbox_material_foreground = "material" -- "material", "mix" eller "original"
		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_transparent_background = 1
		vim.g.gruvbox_material_better_performance = 1
	end,
}

-- vim: ts=2 sts=2 sw=2 et
