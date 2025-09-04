local ACTIVE_THEME = "catppuccin"

local themes = {
	require("custom.plugins.colorschemes.rose-pine"),
	require("custom.plugins.colorschemes.catppuccin"),
}

-- Sett priority og aktivering basert på valgt theme
for _, theme in ipairs(themes) do
	if theme.name == ACTIVE_THEME then
		theme.priority = 1000
		theme.init = function()
			-- Kjør original config hvis den finnes
			if theme.config then
				theme.config()
			end

			-- Aktiver theme
			vim.cmd("colorscheme " .. ACTIVE_THEME)
		end
		-- Fjern config siden vi kjører den i init
		theme.config = nil
	else
		theme.priority = 999
	end
end

return themes

-- vim: ts=2 sts=2 sw=2 et
