return {
  cmd = {
    "lua-language-server",
  },
  filetypes = {
    "lua",
  },
  root_markers = {
    ".git",
    ".luacheckrc",
    ".luarc.json",
    ".luarc.jsonc",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml",
  },
  settings = {
    Lua = { -- con L maiuscola: è il formato previsto dal server ufficiale
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        checkThirdParty = false, -- evita messaggi di avviso su librerie esterne
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning, -- nome corretto
}
