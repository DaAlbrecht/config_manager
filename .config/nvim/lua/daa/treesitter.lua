local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.apachesynapse = {
    install_info = {
        url = "~/dev/private/rust/lsp/tree-sitter-apache-synapse", -- local path or git repo
        files = { "src/parser.c" },                                -- note that some parsers also require src/scanner.c or src/scanner.cc
        branch = "main",
    },
    filetype = "apachesynapse", -- if filetype does not match the parser name
}

parser_config.ballerina = {
    install_info = {
        url = "https://github.com/heshanpadmasiri/tree-sitter-ballerina", -- local path or git repo
        files = { "src/parser.c" },                                       -- note that some parsers also require src/scanner.c or src/scanner.cc
        branch = "main",
    },
    filetype = "ballerina", -- if filetype does not match the parser name
}
