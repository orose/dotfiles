local cucumber = require("custom.cucumber")

local function map(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { buffer = true, desc = "Cucumber: " .. desc })
end

map("<leader>Ts", cucumber.run_scenario, "Kjør [S]cenario under markøren")
map("<leader>Tf", cucumber.run_file, "Kjør hele [F]eature-fila")
map("<leader>Tl", cucumber.run_last, "Kjør [L]ast på nytt")
map("<leader>Td", function()
	cucumber.run_scenario({ debug = true })
end, "[D]ebug scenario")
map("<leader>TD", function()
	cucumber.run_file({ debug = true })
end, "[D]ebug hele fila")

-- vim: ts=2 sts=2 sw=2 et
