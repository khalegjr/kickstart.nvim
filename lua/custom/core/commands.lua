vim.cmd 'command! Gp !git push -u origin HEAD'
vim.cmd 'command! Gpf !git push -u origin HEAD --force-with-lease'
vim.cmd 'command! -nargs=1 Gcp !git fetch origin && git checkout <args> && git pull'
vim.cmd 'command! Gsc !stash_and_checkout_master.sh'

vim.cmd 'command! -nargs=1 Du !docker-compose up <args> -d'
vim.cmd 'command! -nargs=1 Dr !docker-compose restart <args>'

vim.api.nvim_set_keymap('n', '<Leader>y', [[:lua CopyRelativePathToClipboard()<CR>]], { noremap = true, silent = true })

function CopyRelativePathToClipboard()
  local current_file_path = vim.fn.expand '%'
  vim.fn.system('echo -n ' .. current_file_path .. ' | pbcopy')
  print('Copied to clipboard: ' .. current_file_path)
end

vim.api.nvim_set_keymap('n', '<Leader>fa', [[:lua LspFixAllProblems()<CR>]], { noremap = true, silent = true })

function LspFixAllProblems()
  vim.lsp.buf.code_action {
    filter = function(a)
      return a.title == 'Fix all auto-fixable problems'
    end,
    apply = true,
  }
end
