" This file doesn't work as a lua file, I don't know why.

nnoremap <leader>jo <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap <leader>jv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap <leader>jv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap <leader>jc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap <leader>jc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap <leader>jm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

nnoremap <leader>jx <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>jz <Cmd>lua require'jdtls'.test_nearest_method()<CR>
