-- github.com/saghen/blink.cmp
-- Completion (LSP, path, buffer, built-in vim.snippet)
vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") } })

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-CR>"] = { "accept", "fallback" },
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	completion = {
		list = { selection = { preselect = true, auto_insert = false } },
		documentation = { auto_show = true },
	},
	sources = { default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
