-- github.com/akinsho/bufferline.nvim
-- Buffer tabs
vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

local function delete_buffer(n)
	require("mini.bufremove").delete(n, false)
end

require("bufferline").setup({
	options = {
		close_command = delete_buffer,
		right_mouse_command = delete_buffer,
		diagnostics = "nvim_lsp",
		always_show_bufferline = true,
		offsets = {
			{
				filetype = "neo-tree",
				text = "neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})

local map = vim.keymap.set
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<C-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<C-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
