-- Enhanced lspconfig.lua with inline hints and diagnostics
local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- Configure diagnostics display
vim.diagnostic.config {
  virtual_text = {
    enabled = true,
    source = "always", -- Show source of diagnostic
    prefix = "●", -- Could be '■', '▎', 'x', '●', etc.
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
