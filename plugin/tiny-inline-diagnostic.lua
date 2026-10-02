-- github.com/rachartier/tiny-inline-diagnostic.nvim
-- Boxed diagnostic messages beside the cursor line
vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("tiny-inline-diagnostic").setup({ preset = "modern" })
-- The plugin draws its own inline messages; the built-in ones would duplicate them.
vim.diagnostic.config({ virtual_text = false })
