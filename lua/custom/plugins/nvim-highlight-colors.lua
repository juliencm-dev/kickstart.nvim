return {
  'brenoprata10/nvim-highlight-colors',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    render = 'background',
    virtual_symbol = '■',
    enable_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_named_colors = true,
    enable_tailwind = true,
  },
  config = function(_, opts)
    require('nvim-highlight-colors').setup(opts)
  end,
}
