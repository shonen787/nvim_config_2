return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")

		-- Setup Neotree with event handler to close on file open
		require("neo-tree").setup({
			enable_git_status = true,
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						-- Automatically close Neotree when a file is opened
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
        {
          event = "file_open_requested",
          handler = function ()
            require("neo-tree.command").execute({action = "close"})
          end
        },
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.cmd("highlight! Cursor blend=100")
					end,
				},
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						vim.cmd("highlight! Cursor guibg=#ffffff blend=0")
					end,
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			window = { mappings = { ["<CR>"] = "open_tabnew" } },
		})
	end,
}
