vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")

-- Build steps for plugins that ship native code or parsers. Registered here,
-- before plugin/*.lua runs vim.pack.add, so they also fire on first install.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end
		if name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		elseif name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		elseif name == "gopher.nvim" then
			-- Plugin commands only exist once plugin/gopher.lua has run.
			vim.schedule(function()
				pcall(vim.cmd.GoInstallDeps)
			end)
		end
	end,
})
