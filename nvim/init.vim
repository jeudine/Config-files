if has("syntax")
    syntax on
endif

if has("autocmd")
    filetype plugin indent on
endif

set background=dark

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

autocmd FileType c,cpp,cuda setlocal equalprg=clang-format
autocmd FileType rust setlocal equalprg=rustfmt noet ci pi sts=0 sw=4 ts=4

set nosmartindent
set cindent
set list
set listchars=tab:\│\-,trail:~
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

let g:ale_c_parse_makefile = 1
let g:ale_linters = {'cpp': ['g++'], 'c': ['gcc']}
let g:ale_c_gcc_options='-std=gnu11 -Wall -Werror'

".h files correspond to c
au BufRead,BufNewFile *.h set filetype=c

"Cursor shape when leaving
autocmd VimLeave * set guicursor=a:ver100
nmap <silent> <C-e> <Plug>(ale_next_wrap)
