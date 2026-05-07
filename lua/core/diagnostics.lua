-- [[ Diagnostic Configuration ]]

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config { signs = { text = diagnostic_signs } }
end
