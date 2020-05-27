" Vim filetype plugin file

augroup filetypedetect
   au! BufRead,BufNewFile *.sv,*.hsv,*.svh       setfiletype systemverilog
   au! BufRead,BufNewFile *.v,*.vqm,*.vh   setfiletype verilog
augroup END

" Behaves just like Verilog
runtime! ftplugin/verilog.vim
