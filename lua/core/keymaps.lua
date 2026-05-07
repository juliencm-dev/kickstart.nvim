-- [[ Keymaps ]]
-- All global (non-buffer-local) keymaps in one place.
-- Buffer-local keymaps (LSP) remain in their plugin configs.

local map = vim.keymap.set

-- ── General ──────────────────────────────────────────────────────────
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
map('n', '<leader>w', ':w<CR>', { desc = '[W]rite current buffer', noremap = true, silent = true })
map('n', '<leader>q', ':q<CR>', { desc = '[Q]uit current window', noremap = true, silent = true })
map('n', '<leader>nr', ':reg<CR>', { desc = '[N]vim [R]egisters' })

-- Exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- ── Diagnostics ──────────────────────────────────────────────────────
map('n', '<leader>od', function()
  vim.diagnostic.open_float(nil, { border = 'rounded', scope = 'cursor' })
end, { desc = '[O]pen [D]iagnostic float' })
map('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostic [Q]uickfix list' })

-- ── Search (Telescope) ──────────────────────────────────────────────
map('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', function()
  require('telescope.builtin').keymaps()
end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', function()
  require('telescope.builtin').find_files()
end, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', function()
  require('telescope.builtin').lsp_document_symbols { initial_text = '' }
end, { desc = '[S]earch [S]ymbols' })
map('n', '<leader>sw', function()
  require('telescope.builtin').grep_string()
end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', function()
  require('telescope.builtin').live_grep()
end, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', function()
  require('telescope.builtin').diagnostics()
end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', function()
  require('telescope.builtin').resume()
end, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', function()
  require('telescope.builtin').oldfiles()
end, { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', function()
  require('telescope.builtin').buffers()
end, { desc = '[ ] Find existing buffers' })

map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

map('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- ── Harpoon ──────────────────────────────────────────────────────────
map('n', '<leader>hm', function()
  require('harpoon.mark').add_file()
end, { desc = '[H]arpoon [M]ark' })
map('n', '<leader>hq', ':Telescope harpoon marks<CR>', { desc = '[H]arpoon [Q]uick Menu', noremap = true, silent = true })
map('n', '<leader>hn', function()
  require('harpoon.ui').nav_next()
end, { desc = '[H]arpoon [N]ext' })
map('n', '<leader>hp', function()
  require('harpoon.ui').nav_prev()
end, { desc = '[H]arpoon [P]revious' })
map('n', '<leader>hc', function()
  require('harpoon.mark').clear_all()
end, { desc = '[H]arpoon [C]lear All' })

-- ── Flash ────────────────────────────────────────────────────────────
-- stylua: ignore start
map({ 'n', 'x', 'o' }, 'zk', function() require('flash').jump() end, { desc = 'Flash' })
map({ 'n', 'x', 'o' }, 'zt', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
map('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
map({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
map('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
-- stylua: ignore end

-- ── Debug (DAP) ──────────────────────────────────────────────────────
map('n', '<F5>', function()
  require('dap').continue()
end, { desc = 'Debug: Start/Continue' })
map('n', '<F1>', function()
  require('dap').step_into()
end, { desc = 'Debug: Step Into' })
map('n', '<F2>', function()
  require('dap').step_over()
end, { desc = 'Debug: Step Over' })
map('n', '<F3>', function()
  require('dap').step_out()
end, { desc = 'Debug: Step Out' })
map('n', '<leader>b', function()
  require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
map('n', '<F7>', function()
  require('dapui').toggle()
end, { desc = 'Debug: See last session result.' })

-- ── Formatting ───────────────────────────────────────────────────────
map('', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- ── Misc ─────────────────────────────────────────────────────────────
map({ 'n', 'x' }, 'gx', '<cmd>Browse<cr>', { desc = 'Open URL under cursor' })
