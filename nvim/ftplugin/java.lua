-- JDTLS (Java LSP) configuration
local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name .. '_workjdtld'

-- 운영 체제에 따라 변수 설정
local java_17_path
local configuration_os
local nvim_data

if vim.fn.has("win64") == 1 then
		java_17_path = 'C:/Program Files/OpenLogic/jdk-17.0.13.11-hotspot'
		configuration_os = 'config_win'
elseif vim.fn.has("unix") == 1 then
		java_17_path = '/usr/lib/jvm/java-17-openjdk-amd64'
		configuration_os = 'config_linux'
		nvim_data = '/home/piseregna/.local/share/nvim/'
else
	-- Others
	java_17_path = 'error; find this log in ~/.config/nvim/ftplugin/java.lua'
	configuration_os = 'error; find this log in ~/.config/nvim/ftplugin/java.lua'
end

-- Needed for debugging
--local bundles = {
--	vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
--}

-- Needed for running/debugging unit tests
--vim.list_extend(bundles,
--	vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))

-- Funzione per caricare il file di configurazione del singolo progetto
-- deve essere creto il file jdtls_config.lua con le impostazioni del progetto, altrimenti usera le impostazioni di default
local function load_project_config()
  local config_path = vim.fn.getcwd() .. "/jdtls_config.lua"
  local config = {}

  if vim.fn.filereadable(config_path) == 1 then
    config = dofile(config_path)
  else
    config = {
      java_home = "/usr/lib/jvm/java-17-openjdk-amd64",
      output_dir = "./bin",
      source_dir = "./src",
      referenced_libraries = {},
    }
  end

  return config
end

local project_config = load_project_config()

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		java_17_path ..'/bin/java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-javaagent:' .. nvim_data .. 'mason/share/jdtls/lombok.jar',
		'-Xmx4g',
--		'--add-modules=ALL-SYSTEM,jdk.incubator.foreign,jdk.incubator.vector',
--    '--add-opens=java.base/jdk.internal.loader=ALL-UNNAMED,java.base/java.util=ALL-UNNAMED, java.base/java.lang=ALL-UNNAMED',

		-- Eclipse jdtls location
		'-jar', nvim_data .. 'mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
		-- TODO Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
		'-configuration', nvim_data .. 'mason/packages/jdtls/' .. configuration_os,
		'-data', workspace_dir
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'pom.xml', 'build.gradle', 'build.xml', '.svn', 'src' }),

-- Caching dei workspace: Il valore di workspace_folder viene generato automaticamente in base al nome del progetto. Questo evita conflitti tra progetti con lo stesso nome.
	workspace_folder = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			home = project_config.java_home,
      project = {
        outputPath = project_config.output_dir,
        sourcePaths = { project_config.source_dir },
				referencedLibraries = vim.split(vim.fn.glob(project_config.referenced_libraries[1], 1), "\n"),
      },
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
				runtimes = {
					{
						name = "JavaSE-17",
						path = java_17_path,
					},
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/java-8-openjdk-amd64",
					},
					-- {
					-- 	name = "JavaSE-8",
					-- 	path = "C:/Program Files/Java/jdk1.8.0_202",
					-- },
				}
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				settings = {
				  url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
				  profile = "GoogleStyle",
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()} = ${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useInstanceof = false,
					useJava7Objects = true,
				},
				useBlocks = true,
				insertLocation = true,
			},
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org"
			},
		},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
	},
	init_options = {
		workspace = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
		bundles = bundles,
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles
	},
	-- Add handlers for status and progress messages
	handlers = {
		['language/status'] = function(_, result)
			print(result.message)
		end,
		['$/progress'] = function(_, result, ctx)
			-- disable progress updates
		end,
	},
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
		local opts = { noremap = true, silent = true }

		buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
		buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
		buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		client.server_capabilities.document_formatting = true
	end
}

-- Needed for debugging
-- config['on_attach'] = function(client, bufnr)
-- 	jdtls.setup_dap({ hotcodereplace = 'auto' })
-- 	require('jdtls.dap').setup_dap_main_class_configs()
-- end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
require('jdtls').start_or_attach(config)
