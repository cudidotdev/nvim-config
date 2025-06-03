local options = {
  -- default formatters/pathresolver for different content types
  contenttypes = {
    ["application/json"] = {
      ft = "http",
      formatter = vim.fn.executable "jq" == 1 and { "jq", "." },
      pathresolver = function(...)
        return require("kulala.parser.jsonpath").parse(...)
      end,
    },
    ["application/xml"] = {
      ft = "xml",
      formatter = vim.fn.executable "xmllint" == 1 and { "xmllint", "--format", "-" },
      pathresolver = vim.fn.executable "xmllint" == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
    },
    ["text/html"] = {
      ft = "html",
      formatter = vim.fn.executable "xmllint" == 1 and { "xmllint", "--format", "--html", "-" },
      pathresolver = nil,
    },
    ["text/plain"] = {
      ft = "http",
      formatter = nil,
      pathresolver = nil,
    },
  },

  ui = {
    -- display mode: possible values: "split", "float"
    display_mode = "float",
    -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
    default_view = "headers_body",
    -- enable winbar
    winbar = false,

    lua_syntax_hl = true,

    show_request_summary = false,
  },

  -- Enable global keymaps
  global_keymaps = true,
  global_keymaps_prefix = "<leader>l",
  -- Additional useful options
  default_env = "dev",
  debug = false,
}

return options
