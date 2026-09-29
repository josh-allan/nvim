-- github.com/olexsmir/gopher.nvim
-- Go helpers: struct tags, if err, tests
vim.pack.add({
	"https://github.com/olexsmir/gopher.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("gopher").setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
		dlv = "dlv",
	},
	gotests = {
		-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
		template = "default",
		-- path to a directory containing custom test code templates
		template_dir = nil,
		-- switch table tests from using slice to map (with test name for the key)
		-- works only with gotests installed from develop branch
		named = false,
	},
	gotag = {
		transform = "snakecase",
	},
})

vim.keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>", { desc = "Go: add json tags" })
vim.keymap.set("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Go: if err" })
