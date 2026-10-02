-- github.com/MeanderingProgrammer/render-markdown.nvim
-- Renders markdown in normal mode; insert mode shows the raw source for editing
vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

require("render-markdown").setup({
	-- Modes where rendering is active. Leaving out "i" shows raw markdown while typing.
	render_modes = { "n", "c", "t" },
	-- Render the cursor line too, so normal mode shows the full rendered view.
	anti_conceal = { enabled = false },
})
