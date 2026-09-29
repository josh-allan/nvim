-- github.com/pwntester/octo.nvim
-- GitHub issues and PR reviews
vim.pack.add({
	"https://github.com/pwntester/octo.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("octo").setup({ picker = "telescope" })

vim.keymap.set("n", "<leader>opr", "<cmd>Octo pr list<cr>", { desc = "Octo: PR list" })
vim.keymap.set("n", "<leader>ors", "<cmd>Octo review start<cr>", { desc = "Octo: start review" })
vim.keymap.set("n", "<leader>orr", "<cmd>Octo review resume<cr>", { desc = "Octo: resume review" })
vim.keymap.set("n", "<leader>orc", "<cmd>Octo review commit<cr>", { desc = "Octo: review commit" })
vim.keymap.set("n", "<leader>ord", "<cmd>Octo review submit<cr>", { desc = "Octo: submit review" })
