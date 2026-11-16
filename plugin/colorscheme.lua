-- Colorscheme named by ~/.config/theme/nvim.lua, which chezmoi renders from the dotfiles'
-- home/.chezmoidata/theme.toml. Without that file, Catppuccin Mocha.
local fallback = { colorscheme = "catppuccin-mocha", name = "catppuccin", src = "https://github.com/catppuccin/nvim" }
local ok, theme = pcall(dofile, vim.fn.expand("~/.config/theme/nvim.lua"))
if not ok or type(theme) ~= "table" then
	theme = fallback
end

vim.pack.add({ { src = theme.src, name = theme.name } })
if theme.name == "catppuccin" then
	require("catppuccin").setup({ flavour = "mocha" })
end
vim.cmd.colorscheme(theme.colorscheme)
