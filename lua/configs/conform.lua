local options = {
  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    toml = { "taplo" },
    rust = { "rustfmt" },
    css = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    lua = { "stylua" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
