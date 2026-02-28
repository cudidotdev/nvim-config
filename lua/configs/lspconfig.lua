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

-- Servers to install and configure
local servers = {
  "ts_ls", -- Modern TypeScript LSP (replaces tsserver)
  "tailwindcss",
  "eslint",
}

require("nvchad.configs.lspconfig").defaults()

-- TypeScript/JavaScript LSP (modern ts_ls)
require("lspconfig").ts_ls.setup {
  on_attach = function(client, bufnr)
    configs.on_attach(client, bufnr)
    -- Disable formatting (use conform/prettier instead)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- Tailwind CSS
require("lspconfig").tailwindcss.setup {
  on_attach = configs.on_attach,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
  settings = {
    tailwindCSS = {
      files = {
        exclude = {
          "**/.git/**",
          "**/node_modules/**",
          "**/.next/**",
          "**/dist/**",
          "**/build/**",
          "**/plasmo/**",
          "**/.plasmo/**",
        },
      },
    },
  },
}

-- ESLint
require("lspconfig").eslint.setup {
  on_attach = function(client, bufnr)
    configs.on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
}
