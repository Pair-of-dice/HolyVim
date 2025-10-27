" This file doesn't work as a lua file, I don't know why.

nnoremap <leader>ljo <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap <leader>ljv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap <leader>ljv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap <leader>ljc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap <leader>ljc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap <leader>ljm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
