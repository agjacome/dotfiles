local group   = vim.api.nvim_create_augroup('dotfiles', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePost', {
    group   = group,
    pattern = '**.nix',
    command = [[!nix fmt]] -- % && home-manager switch --impure
})

-- autocmd('BufWritePost', {
--     group   = group,
--     pattern = 'config/**',
--     command = [[belowright 20split | terminal chezmoi apply --verbose --source-path %]]
-- })
