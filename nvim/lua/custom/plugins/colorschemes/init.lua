local ACTIVE_THEME = "modus"

local themes = {
	require("custom.plugins.colorschemes.rose-pine"),
	require("custom.plugins.colorschemes.catppuccin"),
	require("custom.plugins.colorschemes.modus"),
	require("custom.plugins.colorschemes.solarized"),
}

for _, theme in ipairs(themes) do
	if theme.name == ACTIVE_THEME then
		theme.priority = 1000
		local original_config = theme.config
		local dark_cs = theme.dark_colorscheme
		local light_cs = theme.light_colorscheme
		local static_cs = theme.colorscheme

		theme.config = function()
			if original_config then
				original_config()
			end
			if dark_cs and light_cs then
				require("auto-dark-mode").setup({
					set_dark_mode = function()
						vim.o.background = "dark"
						vim.cmd.colorscheme(dark_cs)
					end,
					set_light_mode = function()
						vim.o.background = "light"
						vim.cmd.colorscheme(light_cs)
					end,
				})
			elseif static_cs then
				vim.cmd("colorscheme " .. static_cs)
			end
		end

		if dark_cs and light_cs then
			theme.dependencies = theme.dependencies or {}
			table.insert(theme.dependencies, "f-person/auto-dark-mode.nvim")
		end
	else
		theme.priority = 999
	end
end

return themes

-- vim: ts=2 sts=2 sw=2 et
