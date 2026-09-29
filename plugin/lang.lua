-- github.com/pmizio/typescript-tools.nvim, github.com/linux-cultist/venv-selector.nvim
-- TypeScript server wrapper and Python virtualenv picker
vim.pack.add({
	"https://github.com/pmizio/typescript-tools.nvim",
	"https://github.com/linux-cultist/venv-selector.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-telescope/telescope.nvim",
})

require("typescript-tools").setup({})
require("venv-selector").setup()
vim.keymap.set("n", ",v", "<cmd>VenvSelect<cr>", { desc = "Select Python venv" })
