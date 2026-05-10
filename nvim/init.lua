-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Auto read when the file updated
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "CursorHold" }, {
	callback = function()
		vim.cmd("checktime")
	end,
})
