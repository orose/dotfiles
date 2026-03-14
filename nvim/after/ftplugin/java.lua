_G.JavaFoldExpr = function(lnum)
	local line = vim.fn.getline(lnum)
	local prev = lnum > 1 and vim.fn.getline(lnum - 1) or ""

	if line:match("^import ") then
		return prev:match("^import ") and "1" or ">1"
	end

	local sw = vim.bo.shiftwidth
	if sw == 0 then sw = vim.bo.tabstop end
	if sw == 0 then sw = 4 end
	return tostring(math.floor(vim.fn.indent(lnum) / sw))
end

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.JavaFoldExpr(v:lnum)"
-- vim: ts=2 sts=2 sw=2 et
