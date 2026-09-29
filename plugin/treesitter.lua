-- github.com/nvim-treesitter/nvim-treesitter
-- Parser installation; highlighting and indent come from Neovim itself
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").install({
	"bash",
	"go",
	"html",
	"hcl",
	"javascript",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"terraform",
	"typescript",
	"vim",
	"vimdoc",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		if pcall(vim.treesitter.start, ev.buf) then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
