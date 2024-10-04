-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--- Options

--- Numbering, cursorline, folding
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.foldcolumn = "1"
--- Read modelines
vim.o.modeline = true
--- Default indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.colorcolumn = "80"
--- File browser
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 1

--- Keybindings

vim.keymap.set('n', '<space>b', ':Lexplore!\n')

--- Plugins

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			'maxmx03/solarized.nvim',
			lazy = false,
			priority = 1000,
			config = function()
				if vim.env.LIGHT == 'true' then
					vim.o.background = 'light'
				else
					vim.o.background = 'dark'
				end
				vim.cmd.colorscheme 'solarized'
			end,
		},
		"nvim-treesitter/nvim-treesitter",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "solarized" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Configure LSP keymapping
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	--- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	--- Zed
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'g<C-d>', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
	vim.keymap.set('n', 'gS', vim.lsp.buf.workspace_symbol, bufopts)
	vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gA', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', 'cd', vim.lsp.buf.rename, bufopts)
	--- Custom
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	--- Workspace
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

-- Configure LSP servers
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers {
	function(server_name)
		local lspconfig =
			require('lspconfig')[server_name].setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
	end
}
