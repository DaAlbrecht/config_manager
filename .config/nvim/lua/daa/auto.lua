function set_typ_equalprg()
    vim.bo.equalprg = 'typstfmt --stdout'
end

vim.cmd([[autocmd FileType typst lua set_typ_equalprg()]])

vim.cmd [[autocmd BufNewFile,BufRead Jenkinsfile setf groovy]]
