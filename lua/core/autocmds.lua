-- [[ Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Prettier indent sync for JS/TS
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'tsx' },
  callback = function()
    local cfg_path = vim.fn.findfile('.prettierrc', '.;')
    if cfg_path ~= '' then
      local json = vim.fn.json_decode(table.concat(vim.fn.readfile(cfg_path), '\n'))
      if json then
        if json.tabWidth then
          vim.opt_local.shiftwidth = json.tabWidth
          vim.opt_local.tabstop = json.tabWidth
        end
        if json.useTabs ~= nil then
          vim.opt_local.expandtab = not json.useTabs
        else
          vim.opt_local.expandtab = true
        end
      end
    else
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.expandtab = true
    end
  end,
})

-- Force C / C++ / header files to use specific indent
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
