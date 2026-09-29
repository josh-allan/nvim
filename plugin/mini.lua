-- github.com/nvim-mini/mini.nvim
-- Textobjects, surround, pairs, file browser, statusline, pickers
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- va) / yinq / ci' style around/inside textobjects
require("mini.ai").setup({ n_lines = 500 })
-- saiw) add, sd' delete, sr)' replace surroundings
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.files").setup()
require("mini.bufremove").setup()
require("mini.extra").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

vim.keymap.set("n", "<leader>gb", function()
	MiniExtra.pickers.git_commits({ path = vim.fn.expand("%:p") })
end, { desc = "Git Log this File" })
