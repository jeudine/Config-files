if has("syntax")
    syntax on
endif

if has("autocmd")
    filetype plugin indent on
endif

set background=dark

" Using tabs for indentation
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

set nosmartindent
set autoindent
set cindent
set list
set listchars=tab:\│\-,trail:~

set noshowmode

" Format
autocmd FileType c,cpp,cuda setlocal equalprg=clang-format
autocmd FileType rust setlocal equalprg=rustfmt noet ci pi sts=0 sw=4 ts=4

" Smart case
set ignorecase
set smartcase

" No comments insertion below a comment
au BufEnter * set formatoptions-=ro

" Tag jumping

" Create the ctags file
command! Maketags !ctags --langmap=c:+.cu src/*

" Update the ctags file
function! DelTagOfFile(file)
  	let fullpath = a:file
  	let cwd = getcwd()
  	let tagfilename = cwd . "/tags"
  	let f = substitute(fullpath, cwd . "/", "", "")
  	let f = escape(f, './')
  	let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  	let resp = system(cmd)
endfunction

function! UpdateTags()
  	let f = expand("%:p")
  	let cwd = getcwd()
  	let tagfilename = cwd . "/tags"
  	let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  	call DelTagOfFile(f)
  	let resp = system(cmd)
endfunction
autocmd BufWritePost src/* call UpdateTags()

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  	" Save the last search.
  	let search = @/

  	" Save the current cursor position.
  	let cursor_position = getpos('.')

  	" Save the current window position.
  	normal! H
  	let window_position = getpos('.')
  	call setpos('.', cursor_position)

  	" Execute the command.
  	execute a:command

  	" Restore the last search.
  	let @/ = search

  	" Restore the previous window position.
  	call setpos('.', window_position)
  	normal! zt

  	" Restore the previous cursor position.
  	call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  	call Preserve('normal gg=G')
endfunction

" Indent on save hook
autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.cu,*.cuh,*.rs,*.sh,*.vim call Indent()

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

" ALE configuration
let g:ale_set_highlights = 0
let g:ale_c_parse_makefile = 1
let g:ale_linters = {'cpp': ['g++'], 'c': ['gcc']}
let g:ale_c_gcc_options='-std=gnu11 -Wall -Werror'
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" .h files correspond to c
au BufRead,BufNewFile *.h set filetype=c

" Cursor shape when leaving
autocmd VimLeave * set guicursor=a:ver100

" Enable local configuration file
set exrc
