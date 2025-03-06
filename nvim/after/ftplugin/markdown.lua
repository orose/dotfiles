vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.showbreak = "↪ " -- Valgfritt symbol for brutte linjer

vim.keymap.set("n", "j", "gj", { noremap = true, buffer = true })
vim.keymap.set("n", "k", "gk", { noremap = true, buffer = true })
