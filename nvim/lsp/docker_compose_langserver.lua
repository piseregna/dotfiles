return {
  cmd = {
    'docker-compose-langserver', '--stdio'
  },
  filetypes = {
    "yaml",
    --"yaml.docker-compose",
  },
  root_markers = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning, -- nome corretto
}
--    vim.lsp.config('docker_compose_language_service', {
--      settings = {
--        filetypes = { 'yaml.docker-compose' },
--        root_dir = util.root_pattern('docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml'),
--        single_file_support = true,
--      },
--    })
