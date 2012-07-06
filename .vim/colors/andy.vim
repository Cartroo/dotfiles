
" Andy's syntax highlighting settings

set background=dark
hi clear
if exists("syntax on")
  syntax reset
endif
let colors_name="andy"

hi Normal         term=NONE                 ctermfg=White      guifg=#eeeeee guibg=Black
hi Comment        term=underline            ctermfg=DarkCyan   guifg=#22bbbb guibg=Black
hi SpecialComment term=underline            ctermfg=Cyan       guifg=#00ffff guibg=Black
hi Constant       term=NONE                 ctermfg=Yellow     guifg=#ffef00 guibg=Black
hi Special        term=bold                 ctermfg=LightGreen guifg=#33dd11 guibg=Black
hi Identifier     term=bold      cterm=bold ctermfg=LightBlue  guifg=#33bbee guibg=Black
hi Statement      term=bold      cterm=bold ctermfg=White      guifg=#ffffff guibg=Black gui=bold
hi PreProc        term=bold      cterm=bold ctermfg=DarkRed    guifg=#aa2222 guibg=Black
hi Type           term=bold      cterm=bold ctermfg=Cyan       guifg=#00ffff gui=bold guibg=Black
hi Ignore                                   ctermfg=Black      guifg=Black   guibg=Black
hi String         term=underline            ctermfg=DarkGreen  guifg=#228800 guibg=Black
hi Character      term=underline            ctermfg=DarkGreen  guifg=#228800 guibg=Black
" Bear in mind that status lines are reverse video!!!
hi StatusLine term=reverse ctermbg=White ctermfg=Blue guibg=DarkBlue guifg=White
hi StatusLineNC term=reverse ctermbg=White ctermfg=DarkBlue guibg=DarkBlue guifg=Black
hi Pmenu term=reverse ctermbg=Gray ctermfg=White
hi Error term=reverse ctermbg=DarkRed ctermfg=White guibg=Red guifg=White
hi SpellBad term=reverse ctermbg=DarkRed guibg=Red


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

