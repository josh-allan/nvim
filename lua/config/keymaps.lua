local map = vim.keymap.set

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
map("n", "<M-\\>", "<cmd>rightbelow vsplit<CR>", { desc = "Split window to the right" })
map("n", "<M-->", "<cmd>rightbelow split<CR>", { desc = "Split window below" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
map("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>", { desc = "Update all pack plugins" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<S-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<S-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

local directions = {
	h = "left",
	j = "down",
	k = "up",
	l = "right",
}

local function focus_rex(direction)
	local session = vim.env.REX_SESSION
	if not session or session == "" then
		return
	end

	local command = {
		"rex",
		"api",
		"call",
		"--session",
		session,
		"session.focus_direction",
		vim.json.encode({ direction = direction, wrap = false }),
	}
	local ok, err = pcall(vim.system, command, { text = true }, function(result)
		if result.code ~= 0 then
			vim.schedule(function()
				vim.notify("Rex pane focus failed: " .. (result.stderr or ""), vim.log.levels.WARN)
			end)
		end
	end)
	if not ok then
		vim.notify("Rex pane focus failed: " .. tostring(err), vim.log.levels.WARN)
	end
end

for key, direction in pairs(directions) do
	vim.keymap.set("n", "<D-" .. key .. ">", function()
		local current = vim.api.nvim_get_current_win()
		local neighbor_number = vim.fn.winnr(key)
		if neighbor_number ~= 0 then
			local neighbor = vim.fn.win_getid(neighbor_number)
			if neighbor ~= current then
				vim.api.nvim_set_current_win(neighbor)
				return
			end
		end
		focus_rex(direction)
	end, { desc = "Move focus " .. direction .. " across Neovim and Rex" })
end

map("", "Y", "y$", { silent = true, desc = "Yank to end of line" })
-- Keep the cursor where it was after a visual yank
map("v", "y", "ygv<Esc>", { silent = true })

map("n", "<", "V<gv", { remap = true, silent = true })
map("n", ">", "V>gv", { remap = true, silent = true })
map("x", "<", "<gv", { silent = true })
map("x", ">", ">gv", { silent = true })

map("n", "<leader>wt", [[:%s/\s\+$//e<cr>]], { desc = "Remove trailing whitespace" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Typing `{` inside a Python string turns it into an f-string.
vim.api.nvim_create_autocmd("InsertCharPre", {
	pattern = { "*.py" },
	group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
	callback = function(opts)
		if vim.v.char ~= "{" then
			return
		end

		local node = vim.treesitter.get_node()
		if not node then
			return
		end
		if node:type() ~= "string" then
			node = node:parent()
		end
		if not node or node:type() ~= "string" then
			return
		end

		local row, col = vim.treesitter.get_node_range(node)
		local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
		if first_char == "f" then
			return
		end

		vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
	end,
})
