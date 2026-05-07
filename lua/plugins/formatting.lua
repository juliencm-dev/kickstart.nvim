return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,

    formatters = {
      prettierd = {
        cwd = function(ctx)
          return vim.fs.dirname(vim.fs.find({ '.prettierrc', 'prettier.config.js', 'package.json', '.git' }, {
            upward = true,
            path = ctx.filename,
          })[1])
        end,
      },
      prettier = {
        args = { '--stdin-filepath', '$FILENAME' },
      },
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format', 'isort', 'black' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports', 'gofmt' },
      java = { 'google_java_format' },
      cpp = { 'clang-format' },
      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace' },
    },
  },
}
