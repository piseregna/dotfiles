-- LSP Support
return {
	-- LSP Configuration
	'neovim/nvim-lspconfig',
	event = 'VeryLazy',
	dependencies = {
		-- LSP Management
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },

		-- Auto-Install LSPs, linters, formatters, debuggers
		{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },

		-- Useful status updates for LSP
		{ 'j-hui/fidget.nvim',                        opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		{ 'folke/neodev.nvim' },
	},
	config = function()
	    local arch = vim.loop.os_uname().machine

		-- platform independent LSP list
		local lsp_install_list = {
			'lua_ls', 		-- lua
			'jdtls',		-- java
			-- 'gradle_ls',	-- gradle
			-- 'yamlls', 		-- yaml,yml (require npm)
			-- 'cssls', 		-- css (require npm)
			-- 'html', 		-- html (require npm)
			-- 'ts_ls',		-- js (require npm)
			-- 'jsonls',		-- json (require npm)
			-- 'ruff_lsp',		-- python
		}

		-- platform dependent LSP list
		if arch ~= 'aarch64' then
			table.insert(lsp_install_list, 'lemminx') -- xml
		end

		require('mason').setup()
		require('mason-lspconfig').setup({
			-- Install these LSPs automatically
			ensure_installed = lsp_install_list
		})

		require('mason-tool-installer').setup({
			-- Install these linters, formatters, debuggers automatically
			ensure_installed = {
				-- Debugger (java, python)
				-- 'java-debug-adapter',
				-- 'java-test',
				-- 'debugpy',
			},
		})

		-- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		vim.api.nvim_command('MasonToolsInstall')

		local lspconfig = require('lspconfig')
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lsp_attach = function(client, bufnr)
			-- Create your keybindings here...
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

      -- Find references for the word under your cursor.
      map("gr", require("telescope.builtin").lsp_references, "Goto References")

      -- Jump to the implementation of the word under your cursor.
      map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")

      -- Jump to the type of the word under your cursor.
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")

      -- Fuzzy find all the symbols in your current document.
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

      -- Fuzzy find all the symbols in your current workspace.
      map("<leader>ss", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

      -- Rename the variable under your cursor.
      map("<leader>rn", vim.lsp.buf.rename, "Rename")

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

      -- Show documentation for what is under cursor
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      -- This is not Goto Definition, this is Goto Declaration.
      map("gD", vim.lsp.buf.declaration, "Goto Declaration")

      -- Mapping to restart lsp if necessary
      map("<leader>rs", ":LspRestart<CR>", "Restart")

      -- Jump to previous diagnostic in buffer
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })

      -- Jump to next diagnostic in buffer
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })

      -- Help with function signature
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
      end, { desc = "Signature help" })

		end

		local mason_lspconfig = require("mason-lspconfig")

	-- Setup deve essere chiamato prima di usare setup_handlers
	mason_lspconfig.setup({
		ensure_installed = lsp_install_list
	})

		-- Call setup on each LSP server
		mason_lspconfig.setup_handlers({
			function(server_name)
				-- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
				if server_name ~= 'jdtls' then
					lspconfig[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end
			end
		})

		-- Lua LSP settings
		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { 'vim' },
					},
				},
			},
		}

    lspconfig.lemminx.setup({
    settings = {
        xml = {
            server = {
                workDir = "~/.cache/lemminx",
            }
        }
    }
})

		-- Globally configure all LSP floating preview popups (like hover, signature help, etc)
		local open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded" -- Set border to rounded
			return open_floating_preview(contents, syntax, opts, ...)
		end
	end
}
