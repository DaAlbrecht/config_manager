--function set_xml_equalprg()
--    vim.bo.equalprg = 'xmllint --format -'
--end
--
--vim.cmd([[autocmd FileType xml lua set_xml_equalprg()]])

function set_typ_equalprg()
    vim.bo.equalprg = 'typstfmt --stdout'
end

vim.cmd([[autocmd FileType typst lua set_typ_equalprg()]])
