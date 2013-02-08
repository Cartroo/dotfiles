
" Keyboard mappings

" Set up [[, ]], ][ and [] to cope with the heathens who don't put the
" opening brace of a function in the first column
map [[ ?{<CR>w99[{:noh<CR>
map ][ /}<CR>b99]}:noh<CR>
map ]] j0[[%/{<CR>:noh<CR>
map [] k$][%?}<CR>:noh<CR>

" Toggle between 1- and 2-column displays.
map \2 :call Toggle_Two_Columns()<CR>
map \3 :call Toggle_Three_Columns()<CR>

" Map \cp and \cn to cycle through errors in compiler output
map \cp :cprev<CR>
map \cn :cnext<CR>

" Open tag list window.
map \t :TlistToggle<CR>

" Toggle main and header file.
map \he :FSHere<CR>

" Map F2 to cancel highlighting
map <F2> :noh<CR>

" Map F3 and F4 to cycle through tag matches
map <F3> :tprev<CR>
map <F4> :tnext<CR>

" Map F5 and F6 to cycle through buffers
map <F5> :bprev<CR>
map <F6> :bnext<CR>

" Invert case-sensitivity of searching.
"map <F8> :call Invert_Case()<CR>

" Handy mapping to tell us what the current syntax highlighting group
" under the cursor is (useful for debugging syntax highlighting)
map \sy :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Allow opening a file relative to the current file's location.
map \e :e <C-R>=expand("%:p:h") . "/" <CR>

" turn off diff mode (nd = NO DIFFS)
map \nd :set nodiff<CR>:set noscrollbind<CR>:set foldmethod=manual<CR>:set wrap<CR>:set foldcolumn=0<CR>

" collapse blank lines into a single line (CB = COLLAPSE BLANKS)
" WARNING : Works over an entire file, and trashes current search
map \cb GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd

" New print command which uses the correct colour scheme.
command! -nargs=* Hardcopy call DoMyPrint("<args>")

" New grep command with sensible defaults.
command! -nargs=+ Grep execute 'silent grep! -r <args> .' | copen 12

" Map <Tab> to perform completions when appropriate
" inoremap <Tab> <C-R>=CleverTab()<CR>

