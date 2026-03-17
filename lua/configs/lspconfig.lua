require("nvchad.configs.lspconfig").defaults()

-- ── List all servers to enable ──────────────────────────────────────
local servers = {
  "html",
  "cssls",
  "ts_ls",        -- TypeScript / JavaScript / TSX
  "jsonls",       -- JSON
  "taplo",        -- TOML
  "eslint",       -- ESLint as LSP
  "tailwindcss",  -- Tailwind CSS
  "emmet_ls",     -- Emmet
  "lua_ls",
  -- rust_analyzer is handled by rustaceanvim — do NOT add it here
}

vim.lsp.enable(servers)

-- ── Per-server custom config ─────────────────────────────────────────

-- JSON: attach SchemaStore schemas for package.json, tsconfig, etc.
vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas  = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- ESLint: auto-fix on save
vim.lsp.config("eslint", {
  settings = {
    workingDirectory = { mode = "auto" },
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer  = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Tailwind: limit to relevant filetypes
vim.lsp.config("tailwindcss", {
  filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})

-- Emmet: limit to relevant filetypes
vim.lsp.config("emmet_ls", {
  filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})

-- Lua: aware of Neovim runtime + vim global for config editing
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",  -- Neovim uses LuaJIT
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,       -- nvim runtime files (vim.*, vim.lsp.*, etc.)
          "${3rd}/luv/library",     -- luv / vim.uv bindings
        },
      },
      diagnostics = {
        globals = { "vim" },        -- suppress "undefined global vim" warnings
      },
      hint = {
        enable    = true,           -- inlay hints (param names, types)
        arrayIndex = "Disable",     -- less noise in table literals
      },
      format = {
        enable = false,             -- let stylua handle formatting, not lua_ls
      },
    },
  },
})
