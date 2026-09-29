local map = vim.keymap.set

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
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
