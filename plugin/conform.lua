-- github.com/stevearc/conform.nvim
-- Formatting, with format-on-save
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- No LSP fallback for languages without a standard style.
		local disable_filetypes = { c = true, cpp = true }
		return {
			timeout_ms = 500,
			lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback",
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		terraform = { "terraform fmt" },
		shell = { "shfmt" },
		go = { "goimports" },
	},
})

vim.keymap.set("", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })
