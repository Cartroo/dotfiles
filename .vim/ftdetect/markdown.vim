
au BufRead,BufNewFile *.md,*.markdown,*.mkd
        \ if &ft =~# '^\%(conf\|modula2\)$' |
        \     set ft=markdown |
        \ else |
        \     setf markdown |
        \ endif

