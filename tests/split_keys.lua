dofile("lua/config/keymaps.lua")
vim.o.splitright = false
vim.o.splitbelow = false

local function press(key)
	local termcode = vim.api.nvim_replace_termcodes(key, true, false, true)
	vim.api.nvim_feedkeys(termcode, "mx", false)
end

local ok, err = xpcall(function()
	local left = vim.api.nvim_get_current_win()
	press("<M-\\>")
	local right = vim.api.nvim_get_current_win()
	assert(right ~= left, "Alt+backslash did not create a split")
	assert(vim.fn.win_getid(vim.fn.winnr("h")) == left, "split was not placed to the right")

	vim.cmd("only!")
	local top = vim.api.nvim_get_current_win()
	press("<M-->")
	local bottom = vim.api.nvim_get_current_win()
	assert(bottom ~= top, "Alt+minus did not create a split")
	assert(vim.fn.win_getid(vim.fn.winnr("k")) == top, "split was not placed below")
end, debug.traceback)

if not ok then
	io.stderr:write(err .. "\n")
	vim.cmd("cquit 1")
end
io.stdout:write("Neovim split shortcuts verified\n")
vim.cmd("qall!")
