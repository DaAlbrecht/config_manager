require("blink.cmp").setup({
	keymap = {
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },

		["<Up>"] = { "scroll_documentation_up", "fallback" },
		["<Down>"] = { "scroll_documentation_down", "fallback" },

		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

		["<CR>"] = { "accept", "fallback" },
	},
	completion = {
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				border = "rounded",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			},
		},
		menu = {
			border = "rounded",
			draw = {
				columns = {
					{ "label", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
			},
			winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
		},
	},
})
