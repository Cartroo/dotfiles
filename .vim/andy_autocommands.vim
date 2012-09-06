
" Setup to auto-run commands when editing various file types.


" Initialisation autocommands (run upon loading a buffer)
au BufReadPost * if line("'\"") | exe "normal '\"" | endif

" Hook into final exit to restore window size if necessary
au VimLeave * if exists("andyoldcols") | let &columns=andyoldcols | endif

" Autocommands to setup features we only want in certain file types...

" ... For C/C++ files:
au BufEnter * if &ft == "c" || &ft == "cpp" | call CMode_map() | endif
au BufLeave * if &ft == "c" || &ft == "cpp" | call CMode_unmap() | endif

" ... For Perl files:
au BufEnter * if &ft == "perl" | call PerlMode_map() | endif
au BufLeave * if &ft == "perl" | call PerlMode_unmap() | endif

" ... For Python files:
au BufEnter * if &ft == "python" | call PythonMode_map() | endif
au BufLeave * if &ft == "python" | call PythonMode_unmap() | endif

" ... For general code files:
au BufEnter * if &ft == "php" | call CodeMode_map() | endif
au BufLeave * if &ft == "php" | call CodeMode_unmap() | endif
au BufEnter * if &ft == "sh" | call CodeMode_map() | endif
au BufLeave * if &ft == "sh" | call CodeMode_unmap() | endif

" ... For makefiles:
au BufEnter * if &ft == "make" | call MakeMode_map() | endif
au BufLeave * if &ft == "make" | call MakeMode_unmap() | endif
au BufEnter * if &ft == "perforce" | call MakeMode_map() | endif
au BufLeave * if &ft == "perforce" | call MakeMode_unmap() | endif

" ... For XML / HTML:
au BufEnter * if &ft == "xml" || &ft == "html" | call XmlMode_map() | endif
au BufLeave * if &ft == "xml" || &ft == "html" | call XmlMode_unmap() | endif

" Definitions for the "fswitch" plugin
autocmd BufEnter *.cpp let b:fswitchdst='h,hh,hpp' | let b:fswitchlocs='.,..,include,../include'
autocmd BufEnter *.cc let b:fswitchdst='h,hh,hpp' | let b:fswitchlocs='.,..,include,../include'
autocmd BufEnter *.cxx let b:fswitchdst='h,hh,hpp' | let b:fswitchlocs='.,..,include,../include'
autocmd BufEnter *.c let b:fswitchdst='h' | let b:fswitchlocs='.,..,include,../include'
autocmd BufEnter *.h let b:fswitchdst='c,cpp,cc,cxx' | let b:fswitchlocs='.,..,../common'
autocmd BufEnter *.hh let b:fswitchdst='cpp,cc,cxx' | let b:fswitchlocs='.,..,../common'
autocmd BufEnter *.hpp let b:fswitchdst='cpp,cc,cxx' | let b:fswitchlocs='.,..,../common'

" Functions to call when we enter/leave a programming language buffer...

" ... For C-like languages:
fun CMode_map()
  set list
  set cindent
  set cinkeys=0{,0},:,0#,!^F,o,O,e
  set cinwords=if,else,while,do,for,switch
  set shiftwidth=2
  " The imap below maps '{' to a matched pair of { / } and moves the
  " cursor to between the two. Nice for writing code, but I found it
  " annoying for editing it (so I removed it)
  " imap { {<CR> <BS><CR>}<Up><End>
  if ! (&diff)
    set foldmethod=syntax
  endif
endfun

fun CMode_unmap()
  set nocindent
  set nolist
  set shiftwidth=8
  " If you uncomment the above imap, also uncomment this line to cancel it
  " when we leave c-mode
  " iunmap {
  if ! (&diff)
    set foldmethod=manual
  endif
endfun

" .. For Perl files:
fun PerlMode_map()
  set list
  set cindent
  set cinkeys=0{,0},:,!^F,o,O,e
  set cinwords=if,else,while,do,for,eval
  set foldmethod=indent
  set shiftwidth=2
  " See the same line for c-mode, above
  " imap { {<CR> <BS><CR>}<Up><End>
endfun

fun PerlMode_unmap()
  set nocindent
  set nolist
  set foldmethod=manual
  set shiftwidth=8
  " If you uncomment the above imap, also uncomment this line to cancel it
  " when we leave perl-mode
  " iunmap {
endfun

" .. For Python files:
let g:pylint_onwrite = 0

fun PythonMode_map()
  set list
  set smarttab
  set autoindent
  set softtabstop=4
  set shiftwidth=4
  set foldmethod=indent
endfun

fun PythonMode_unmap()
  set nolist
  set nosmarttab
  set noautoindent
  set softtabstop=0
  set shiftwidth=8
  set foldmethod=manual
endfun

fun CodeMode_map()
  set list
  set smarttab
  set autoindent
  set softtabstop=4
  set shiftwidth=4
  set foldmethod=indent
endfun

fun CodeMode_unmap()
  set nolist
  set nosmarttab
  set noautoindent
  set softtabstop=0
  set shiftwidth=8
  set foldmethod=manual
endfun

" ... For makefiles:
fun MakeMode_map()
  set list
  set autoindent
  " We don't want to expand tabs to spaces if we're editing makefiles.
  set noexpandtab
endfun

fun MakeMode_unmap()
  set nolist
  set noautoindent
  " We do, however, want to expand tabs in just about every other file format.
  set expandtab
endfun


" ... For XML / HTML:
fun XmlMode_map()
  set shiftwidth=2
  set autoindent
  set list
  set foldmethod=indent
  set textwidth=79
endfun

fun XmlMode_unmap()
  set shiftwidth=4
  set noautoindent
  set nolist
  set foldmethod=manual
  set textwidth=0
endfun

