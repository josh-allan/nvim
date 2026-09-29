-- Small editing plugins: escape chords, docstrings, pane moves, TODO highlights, indent guides
vim.pack.add({
	"https://github.com/max397574/better-escape.nvim",
	"https://github.com/danymat/neogen",
	"https://github.com/letieu/wezterm-move.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
})

require("better_escape").setup()
require("neogen").setup({})
require("todo-comments").setup({ signs = false })
require("ibl").setup({})

vim.keymap.set("n", "<leader>a", function()
	require("neogen").generate()
end, { desc = "Add Docstring" })
for dir in ("hjkl"):gmatch(".") do
	vim.keymap.set("n", "<C-S-" .. dir .. ">", function()
		require("wezterm-move").move(dir)
	end, { desc = "Move to wezterm/nvim pane " .. dir })
end
