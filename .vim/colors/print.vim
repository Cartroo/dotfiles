
" Andy's syntax highlighting settings

set background=light
hi clear
if exists("syntax on")
    syntax reset
endif
let colors_name="print"

" These are the colous I actually want...

"hi Normal               term=NONE cterm=NONE ctermfg=Black
"hi Comment              term=italic cterm=italic ctermfg=DarkCyan
"hi SpecialComment       term=italic cterm=italic ctermfg=DarkCyan
"hi Constant             term=NONE cterm=NONE ctermfg=DarkYellow
"hi Special              term=bold cterm=bold ctermfg=DarkGreen
"hi Identifier           term=bold cterm=bold ctermfg=DarkGreen
"hi Statement            term=bold cterm=bold ctermfg=Blue
"hi PreProc              term=bold cterm=bold ctermfg=Red
"hi Type                 term=bold cterm=bold ctermfg=DarkBlue
"hi Ignore               term=NONE cterm=NONE ctermfg=LightGray
"hi String               term=NONE cterm=NONE ctermfg=DarkGreen
"hi Character            term=NONE cterm=NONE ctermfg=DarkGreen

" ... but Vim seems to invert red and blue (not sure if this is a bug or
" some attempt to "fix" the colours for dark/light background mismatches) so
" these are the "corrected" colours to compensate:

hi Normal               term=NONE       cterm=NONE      ctermfg=Black
hi Comment              term=italic     cterm=italic    ctermfg=DarkYellow
hi SpecialComment       term=italic     cterm=italic    ctermfg=DarkYellow
hi Constant             term=NONE       cterm=NONE      ctermfg=DarkCyan
hi Special              term=bold       cterm=bold      ctermfg=DarkGreen
hi Identifier           term=bold       cterm=bold      ctermfg=Red
hi Statement            term=bold       cterm=bold      ctermfg=Black
hi PreProc              term=bold       cterm=bold      ctermfg=Blue
hi Type                 term=bold       cterm=bold      ctermfg=DarkRed
hi Ignore               term=NONE       cterm=NONE      ctermfg=LightGray
hi String               term=NONE       cterm=NONE      ctermfg=DarkGreen
hi Character            term=NONE       cterm=NONE      ctermfg=DarkGreen


" Default links of minor types for reference:
"
" String .............. Constant
" Character ........... Constant
" Number .............. Constant
" Boolean ............. Constant
" Float ............... Number
" Function ............ Identifier
" Conditional ......... Statement
" Repeat .............. Statement
" Label ............... Statement
" Operator ............ Statement
" Keyword ............. Statement
" Exception ........... Statement
" Include ............. PreProc
" Define .............. PreProc
" Macro ............... PreProc
" PreCondit ........... PreProc
" StorageClass ........ Type
" Structure ........... Type
" Typedef ............. Type
" Tag ................. Special
" SpecialChar ......... Special
" Delimiter ........... Special
" SpecialComment ...... Special
" Debug ............... Special

