if has("syntax")
    syntax on
endif

set background=dark

if has("autocmd")
    filetype plugin indent on
endif

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

packloadall
silent! helptags ALL
let g:ale_set_highlights = 0
