if has("syntax")
    syntax on
endif

if has("autocmd")
    filetype plugin indent on
endif

set background=dark

set nosmartindent
set cindent
set shiftwidth=4
set expandtab
set softtabstop=4
set list
set listchars=tab:>-,trail:~
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

autocmd FileType asciidoc setlocal spell
autocmd FileType tex setlocal spell

packloadall
silent! helptags ALL

let g:ale_set_highlights = 0

"WIP ALE for C/C++
"let g:ale_c_parse_makefile = 1
"let g:ale_c_parse_compile_commands = 0
"let g:ale_linters = {'cpp': ['g++'], 'c': ['gcc']}
"let g:ale_c_cc_executable = 'gcc'
"let g:ale_cpp_cc_executable = 'g++'
let g:ale_linters = {'cpp': [], 'c': []}

".h files correspond to c
au BufRead,BufNewFile *.h set filetype=c

"Cursor shape when leaving
autocmd VimLeave * set guicursor=a:ver100
