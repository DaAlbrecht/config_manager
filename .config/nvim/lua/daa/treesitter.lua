local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.apachesynapse = {
    install_info = {
        url = "https://github.com/DaAlbrecht/tree-sitter-apachesynapse", -- local path or git repo
        files = { "src/parser.c" },                                      -- note that some parsers also require src/scanner.c or src/scanner.cc
        branch = "main",
    },
    filetype = "apachesynapse", -- if filetype does not match the parser name
}
vim.filetype.add({
    extension = {
        apachesynapse = 'apachesynapse',
    }
})
