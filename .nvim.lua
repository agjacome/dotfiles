local group   = vim.api.nvim_create_augroup('dotfiles', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePost', {
    group   = group,
    pattern = '**.nix',
    command = [[!nix fmt %]]
})
