return {

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "rust",
        "toml",
        "json",
        "json5",
        "html",
        "css",
        "markdown",
        "lua",
        "bash",
        "yaml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  -- Mason: ensure LSP servers are installed
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "typescript-language-server",
        "lua-language-server",
        "taplo",
        "json-lsp",
        "eslint-lsp",
        "tailwindcss-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        -- Formatters
        "prettierd",
        "prettier",
        "rustfmt",
        "stylua",
        -- Linters
        "eslint_d",
        "selene",
        "deno",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Rust: full rust-analyzer wrapper (handles its own LSP setup)
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = { features = "all" },
              inlayHints = {
                bindingModeHints = { enable = true },
                closureCaptureHints = { enable = true },
              },
            },
          },
        },
      }
    end,
  },

  -- Cargo.toml crate version hints
  {
    "Saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- TypeScript extras (project-wide rename, go-to-def through .d.ts)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        expose_as_code_action = "all",
        jsx_close_tag = { enable = true },
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        lua = { "selene" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- JSON schema store
  { "b0o/schemastore.nvim" },

  -- Diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
  },

  -- Auto-close JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "typescriptreact", "javascriptreact" },
    opts = {},
  },

  -- Live rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- Git signs + blame
  {
    "lewis6991/gitsigns.nvim",
    opts = { current_line_blame = true },
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    opts = {},
  },
}
