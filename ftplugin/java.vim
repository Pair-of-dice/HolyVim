" This file doesn't work as a lua file, I don't know why.

nnoremap <leader>lo <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap <leader>lv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap <leader>lv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap <leader>lc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap <leader>lc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap <leader>lm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

nnoremap <leader>lx <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>lz <Cmd>lua require'jdtls'.test_nearest_method()<CR>
