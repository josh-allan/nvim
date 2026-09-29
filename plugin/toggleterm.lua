-- github.com/akinsho/toggleterm.nvim
-- Toggleable terminals in splits and floats
vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

require("toggleterm").setup({
	size = function(term)
		return term.direction == "vertical" and math.floor(vim.o.columns * 0.4) or 15
	end,
})

local Terminal = require("toggleterm.terminal").Terminal
for key, direction in pairs({ ["<A-h>"] = "horizontal", ["<A-v>"] = "vertical", ["<A-i>"] = "float" }) do
	local term = Terminal:new({ direction = direction })
	vim.keymap.set({ "n", "t" }, key, function()
		term:toggle()
	end, { silent = true, desc = "Toggle " .. direction .. " terminal" })
end
