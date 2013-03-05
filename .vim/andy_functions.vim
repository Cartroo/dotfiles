
" Handy functions

" A dirty hack to toggle between case-sensitive and -insensitive
" searching, and update a string on the status bar so we know which
" mode we're in.
" NOTE: This is grim because it overwrites previously set statusline!
"fun Invert_Case()
"  set invic
"  if &ic
"    set statusline=%<%t\ %y%m%r%=case\ \ [%-5.5L]\ %-5.5l\ %-3.3c%V\ %P
"  else
"    set statusline=%<%t\ %y%m%r%=CaSe\ \ [%-5.5L]\ %-5.5l\ %-3.3c%V\ %P
"  endif
"endfun


" Toggles between one and two windows, side-by-size.
fun Toggle_Two_Columns()
  if exists("g:columnsbackup") && g:columnsbackup > 0
    :only
    let &columns=g:columnsbackup
    let g:columnsbackup=0
  else
    let g:columnsbackup=&columns
    let &columns=161
    :vert split
  endif
endfun


" Toggles between one and three windows, side-by-size.
fun Toggle_Three_Columns()
  if exists("g:columnsbackup") && g:columnsbackup > 0
    :only
    let &columns=g:columnsbackup
    let g:columnsbackup=0
  else
    let g:columnsbackup=&columns
    let &columns=242
    :vert split
    :vert split
  endif
endfun


" Set a buffer-local variable to the perforce path, if this file is under the
" Perforce root. 
"function IsUnderPerforce()
"    if exists("$P4HOME")
"        if expand("%:p") =~ ("^" . $P4HOME)
"            let b:p4path = substitute(expand("%:p"), $P4HOME, "//depot/", "")
"        endif
"    endif
"endfunction

" Confirm with the user, then checkout a file from perforce. 
"function P4Checkout()
"   if exists("b:p4path")
"        if (confirm("Checkout from Perforce?", "&Yes\n&No", 1) == 1)
"            call system("/home/apearce/bin/p4edit " . b:p4path . " > /dev/null")
"            if v:shell_error == 0
"                set noreadonly 
"            endif
"        endif
"    endif
"endfunction


" Allow <Tab> to indent on a whitespace line, or complete otherwise.
function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction


" Print with appropriate colour scheme.
function DoMyPrint(args, line1, line2)
 let colorsave=g:colors_name
 color print
 exec a:line1.",".a:line2."hardcopy ".a:args
 exec 'color '.colorsave
endfunction


" Not sure why I ever wrote this, or why it's useful.
fun Reformat_XML()
  :silent 1,$!xmllint --format --recover - 2>/dev/null
endfun

