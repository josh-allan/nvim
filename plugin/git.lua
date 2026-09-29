-- github.com/tpope/vim-fugitive, github.com/NeogitOrg/neogit, github.com/sindrets/diffview.nvim
-- Git commands, Magit-style UI, and diff views
vim.pack.add({
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
})

require("neogit").setup({
	kind = "split",
	signs = {
		-- { CLOSED, OPENED }
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	integrations = { diffview = true },
})

local map = vim.keymap.set
map("n", "<leader>gl", "<cmd>terminal lazygit<cr>", { silent = true, desc = "Lazygit" })
map("n", "<leader>gp", "<cmd>terminal git pull<cr>", { silent = true, desc = "Git Pull" })
map("n", "<leader>gs", "<cmd>terminal git push<cr>", { silent = true, desc = "Git Push" })
map("n", "<leader>ga", "<cmd>terminal git add .<cr>", { silent = true, desc = "Git Add All" })
map(
	"n",
	"<leader>gc",
	'<cmd>terminal git commit -m "Autocommit from nvim"<cr>',
	{ silent = true, desc = "Git Autocommit" }
)
