require("mason").setup()
-- enable all installed lsp's
require("mason-lspconfig").setup()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("K", vim.lsp.buf.hover, "Show [H]over")
		map("gl", vim.diagnostic.open_float, "Show [L]ine diagnostics")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("[d", vim.diagnostic.goto_next, "Go to next diagnostic")
		map("]d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
		map("C-q", vim.lsp.buf.signature_help, "Show signature help", "i")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.lsp.config("*", {
	before_init = function(_, config)
		local codesettings = require("codesettings")
		codesettings.with_local_settings(config.name, config)
	end,
})

-- Set diagnostic icons
local diagnostic_signs = {}
for type, icon in pairs(diagnostics_config.icons.diagnostics) do
	diagnostic_signs[vim.diagnostic.severity[type]] = icon
end
vim.diagnostic.config({ signs = { text = diagnostic_signs } })
