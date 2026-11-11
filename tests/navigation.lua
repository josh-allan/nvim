local original_system = vim.system
local original_session = vim.env.REX_SESSION
local original_server = vim.env.REX_SERVER
local calls = {}

vim.env.REX_SESSION = nil
vim.env.REX_SERVER = nil
vim.system = function(command, options, on_exit)
	assert(type(command) == "table", "Rex must be called with argv, not a shell string")
	table.insert(calls, { command = command, options = options })
	if on_exit then
		on_exit({ code = 0, signal = 0, stdout = "", stderr = "" })
	end
	return {}
end

dofile("lua/config/keymaps.lua")

for _, key in ipairs({ "h", "j", "k", "l" }) do
	assert(vim.fn.maparg("<S-" .. key .. ">", "n") ~= "", "existing Shift+" .. key .. " navigation changed")
end

local function press(key)
	local termcode = vim.api.nvim_replace_termcodes(key, true, false, true)
	vim.api.nvim_feedkeys(termcode, "mx", false)
end

local function current_window()
	return vim.api.nvim_get_current_win()
end

local function close_extra_windows()
	if vim.fn.winnr("$") > 1 then
		vim.cmd("only!")
	end
end

local function check_local_directions()
	close_extra_windows()
	vim.cmd("vsplit")
	local left = current_window()
	local right = vim.fn.win_getid(vim.fn.winnr("l"))
	assert(left ~= 0 and left ~= right, "vertical test split was not created")

	press("<D-l>")
	assert(current_window() == right, "Command/Super+l did not focus the right split")
	press("<D-h>")
	assert(current_window() == left, "Command/Super+h did not focus the left split")

	local bottom = current_window()
	vim.cmd("split")
	local top = current_window()
	assert(top ~= 0 and top ~= bottom, "horizontal test split was not created")

	press("<D-j>")
	assert(current_window() == bottom, "Command/Super+j did not focus the lower split")
	press("<D-k>")
	assert(current_window() == top, "Command/Super+k did not focus the upper split")
	assert(#calls == 0, "local Neovim navigation must not also request Rex focus")
end

local function check_missing_rex_context_is_safe()
	close_extra_windows()
	local before = current_window()
	press("<D-h>")
	assert(current_window() == before, "edge navigation without Rex must not change focus")
	assert(#calls == 0, "edge navigation outside Rex must not invoke its CLI")
end

local function check_rex_edge_handoffs()
	local directions = {
		{ key = "h", direction = "left" },
		{ key = "j", direction = "down" },
		{ key = "k", direction = "up" },
		{ key = "l", direction = "right" },
	}
	vim.env.REX_SESSION = "session:test"

	for _, binding in ipairs(directions) do
		close_extra_windows()
		local before = current_window()
		press("<D-" .. binding.key .. ">")
		assert(current_window() == before, "edge handoff must not move a local window")

		local call = assert(calls[#calls], "Neovim did not request Rex focus: " .. binding.key)
		local command = call.command
		assert(command[1] == "rex")
		assert(command[2] == "api" and command[3] == "call")
		assert(command[4] == "--session" and command[5] == "session:test")
		assert(command[6] == "session.focus_direction")
		local args = vim.json.decode(command[7])
		assert(args.direction == binding.direction, "wrong Rex direction for " .. binding.key)
		assert(args.wrap == false, "Rex edge handoff must not wrap")
		assert(call.options.text == true)
	end
	assert(#calls == #directions, "each edge press must request exactly one Rex focus")
end

local ok, err = xpcall(function()
	check_local_directions()
	check_missing_rex_context_is_safe()
	check_rex_edge_handoffs()
end, debug.traceback)

vim.system = original_system
vim.env.REX_SESSION = original_session
vim.env.REX_SERVER = original_server
if not ok then
	io.stderr:write(err .. "\n")
	vim.cmd("cquit 1")
end
io.stdout:write("Neovim focus navigation verified\n")
vim.cmd("qall!")
