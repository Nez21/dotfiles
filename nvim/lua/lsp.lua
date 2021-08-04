require('spellsitter').setup()
require'colorizer'.setup()
require("todo-comments").setup()

require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,     
	additional_vim_regex_highlighting = false,
	},
}
	
local nvim_lsp = require'lspconfig'
local on_attach = function(client, bufnr)
	require "lsp_signature".on_attach()
end
	
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.codeAction = {
	dynamicRegistration = true,
	codeActionLiteralSupport = {
			codeActionKind = {
				valueSet = (function()
				    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
					table.sort(res)
					return res
					end)()
				}
		}
	}

local servers = { "gopls", "rust_analyzer", "svelte", "html" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	underline = true,
	signs = true,
	update_in_insert = false
})
	
require'lsp_signature'.setup {
	bind = true, 
	handler_opts = {
		border = 'none'
	}
}
require'compe'.setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = 'enable',
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	docmentation = true,
	source = {
		path = true,
		buffer = true,
		calc = true,
		vsnip = true,
		nvim_lsp = true,
		nvim_lua = true,
		spell = true,
		tags = true,
    	snippets_nvim = true
	}
}

require'lspkind'.init {
	with_text = true,
	preset = 'codicons',
	symbol_map = {
		Text = '',
		Method = 'ƒ',
		Function = '',
		Constructor = '',
		Variable = '',
		Class = '',
		Interface = 'ﰮ',
		Module = '',
		Property = '',
		Unit = '',
		Value = '',
		Enum = '了',
		Keyword = '',
		Snippet = '﬌',
		Color = '',
		File = '',
		Folder = '',
		EnumMember = '',
		Constant = '',
		Struct = ''
	},
}
