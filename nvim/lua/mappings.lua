local wk = require("which-key")
wk.register({
    	g = {
        	a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
			D = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
			['0'] = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbol" },
			W = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace Symbol" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			['['] = {	"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to previous" },
			[']'] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to next" }
    	},
		['1'] = {
			g = {
				D = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" }
			}
		},
		F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format code" },
		K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" }
  	}, {
    	mode = "n",
    	prefix = "", 
    	silent = true,
    	noremap = true, 
  	})

wk.register({
    	f = {
			h = { ":DashboardFindHistory<CR>", "Find History" },
			f = { ":DashboardFindFile<CR>", "Find File" },
			a = {":DashboardFindWord<CR>", "Find Word" },
			b = {":DashboardJumpMark<CR>", "Jump Mark" }
		},
		t = {
			c = {":DashboardChangeColorscheme<CR>", "Change Colorscheme" }
		},
		c = {
			n = {":DashboardNewFile<CR>", "New File" }
		},
		s = {
			s = {":<C-u>SessionSave<CR>", "SessionSave", noremap = false },
			l = { ":<C-u>SessionLoad<CR>", "SessionLoad", noremap = false }
		}
  	}, {
    	mode = "n",
    	prefix = "<Leader>", 
    	silent = true,
    	noremap = true, 
  	})

wk.setup {}

vim.cmd'noremap <Esc><Esc> :w<CR>'
vim.cmd[[nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd[[nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>]]
vim.cmd'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'
vim.cmd[[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]]
vim.cmd[[inoremap <silent><expr> <C-Space> compe#complete()]]
vim.cmd[[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]]
vim.cmd[[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]]
vim.cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd[[tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>]]
vim.cmd[[nnoremap <silent> <M-o> :RnvimrToggle<CR>]]
vim.cmd[[tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>]]
