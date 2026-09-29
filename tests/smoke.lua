-- Run: nvim --headless -c "luafile tests/smoke.lua"
local failures = {}
local function check(label, ok)
	if not ok then
		table.insert(failures, label)
	end
end

check("lazy.nvim absent", package.loaded["lazy"] == nil)
check("vim.pack manages plugins", #vim.pack.get() > 30)

for _, mod in ipairs({
	"telescope", "blink.cmp", "dap", "dapui", "conform", "gitsigns", "which-key",
	"neo-tree", "bufferline", "noice", "harpoon", "mini.statusline", "mini.pairs",
	"nvim-treesitter", "treesitter-context", "ibl", "trouble", "octo", "neogit",
	"toggleterm", "gopher",
}) do
	check("require " .. mod, (pcall(require, mod)))
end

for _, cmd in ipairs({ "Telescope", "Neogit", "DiffviewOpen", "Trouble", "VenvSelect", "Git", "Mason", "Octo", "GoTagAdd" }) do
	check("command " .. cmd, vim.fn.exists(":" .. cmd) == 2)
end

check("colorscheme", vim.g.colors_name == "catppuccin-mocha")
for _, lhs in ipairs({ "<Space>f", "<Space>dc", "<Space><Space>", "<Space>e", "<Space>xx", "<Space>gb", "<M-h>" }) do
	check("map " .. lhs, vim.fn.maparg(lhs, "n") ~= "")
end

local errors = vim.tbl_filter(function(line)
	return line:match("E%d+:") or line:match("Error")
end, vim.split(vim.fn.execute("messages"), "\n"))
check("no startup errors: " .. table.concat(errors, " | "), #errors == 0)

if #failures > 0 then
	io.stderr:write("FAIL\n" .. table.concat(failures, "\n") .. "\n")
	vim.cmd("cquit 1")
end
io.stdout:write("PASS\n")
vim.cmd("qall!")
