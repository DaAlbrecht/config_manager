function set_xml_equalprg()
    vim.bo.equalprg = 'xmllint --format -'
end

vim.cmd([[autocmd FileType xml lua set_xml_equalprg()]])
