return {
  cmd = {
    "lemminx",
  },
  filetypes = {
    "xml",
  },
  root_markers = {
    ".git",
  },
  settings = {
    xml = {
      server = {
        workDir = vim.fn.expand("~/.cache/lemminx"), -- espande ~ correttamente
      },
      catalogs = {
        vim.fn.expand("~/.lemminx/catalog.xml"),
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
