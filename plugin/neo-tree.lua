-- github.com/nvim-neo-tree/neo-tree.nvim
-- File explorer
vim.pack.add({
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	git_status = {
		symbols = {
			-- Change type
			added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "✖", -- this can only be used in the git_status source
			renamed = "󰁕", -- this can only be used in the git_status source
			-- Status type
			untracked = "",
			ignored = "",
			unstaged = "󰄱",
			staged = "",
			conflict = "",
		},
	},
	filesystem = {
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
	},
	window = {
		mappings = {
			["J"] = function(state)
				local tree = state.tree
				local node = tree:get_node()
				local siblings = tree:get_nodes(node:get_parent_id())
				local renderer = require("neo-tree.ui.renderer")
				renderer.focus_node(state, siblings[#siblings]:get_id())
			end,
			["K"] = function(state)
				local tree = state.tree
				local node = tree:get_node()
				local siblings = tree:get_nodes(node:get_parent_id())
				local renderer = require("neo-tree.ui.renderer")
				renderer.focus_node(state, siblings[1]:get_id())
			end,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "File explorer" })
