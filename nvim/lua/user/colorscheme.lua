--local colorscheme = "everforest"
local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

-- Transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none"})

