local ACTIVE_THEME = "modus"

local themes = {
	require("custom.plugins.colorschemes.rose-pine"),
	require("custom.plugins.colorschemes.catppuccin"),
	require("custom.plugins.colorschemes.modus"),
	require("custom.plugins.colorschemes.solarized"),
}

-- Sett priority og aktivering basert på valgt theme
for _, theme in ipairs(themes) do
	if theme.name == ACTIVE_THEME then
		theme.priority = 1000
		local original_config = theme.config
		theme.config = function()
			if original_config then
				original_config()
			end
			vim.cmd("colorscheme " .. (theme.colorscheme or ACTIVE_THEME))
		end
	else
		theme.priority = 999
	end
end

return themes

-- vim: ts=2 sts=2 sw=2 et
