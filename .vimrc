
" On Windows systems, set runtimepath to be HOMEDRIVE/HOMEDIR, if set.
if has("win32") || has("win16")
  if exists("$HOMEDRIVE") && exists("$HOMEPATH")
    let &rtp=$HOMEDRIVE.$HOMEPATH.".vim,".&rtp
  endif
endif

set nocompatible

" For some reason VIM seems to think my xterms have a light background!
" What weirdo would use an xterm with a light background?
" (Remove this fudge if you use terminals with a light background)

set background=dark
if &term == "xterm" || &term == "rxvt-unicode"
  set ttymouse=xterm
  set t_Co=88
elseif &term == "xterm-color"
  set ttymouse=xterm
  set t_Co=16
endif

" Fudge for use on the iPad with bluetooth keyboards, where ESC is nabbed for
" the HOME key and can't be remapped (apparently). Use backtick as ESC, where
" <Leader>-` yields a raw backtick instead.
if &term == "xterm-ios"
  nnoremap ` <Esc>
  vnoremap ` <Esc>gV
  onoremap ` <Esc>
  inoremap ` <Esc>`^
  nnoremap <Leader>` `
  inoremap <Leader>` `
endif


" Save the current window width so if we change it we can restore it
" when we quit.
let andyoldcols=&columns

" This expands the terminal to display two 80-column files side-by-side
" when vim is opened in diff mode.
"
if &diff
  let &columns=164
endif

" Now some globally useful variables
"
"  cinoptions      -> C indentation style, see 'help cinoptions-values'
"  formatoptions   -> See 'help fo-table' for details
"  listchars       -> Characters to use in list mode (display tabs, etc..)
"  tags            -> Locations to search for tag file
"  errorformat     -> Used to pick out errors in compiler output
"  cmdheight       -> Lines used for status bar at base of screen
"  shortmess       -> Sets abbreviations to use to shorten status messages
"  laststatus      -> When last window has status bar
"  shiftwidth      -> Default indentation depth (can be overridden)
"  backspace       -> Specifies how much backspacing is allowed
"  mouse           -> In which modes the mouse is enabled
"  foldlevel       -> How many levels of fold to fold
"  rulerformat     -> Format string for the ruler
"  statusline      -> Format string for the status line
"  titlestring     -> Format string for window title bar
"  ic              -> Set to ignore case when searching
"  virtualedit     -> In which modes to allow the cursor to go off the line
"  scroll          -> Number of lines to scroll for CTRL+U and CTRL+D
"  iskeyword       -> Characters which are valid in keywords
"  updatetime      -> Time spent idle (in ms) before swap file written
"  scrolloff       -> Lines of context to keep visible either side of cursor
"  spelllang       -> Language for spell checking (:set spell)

set cinoptions=:0,=s,l1,g0,p0.5s,t0,+s,cs,(0,u0
set formatoptions=tcqrl
set listchars=tab:>-,trail:_,extends:<,precedes:>
set tags=./hipritags;,./tags;,./global_hipritags;,./global_tags;
set errorformat=%f:%l:%c:\ %m,%f:\ %m
set cmdheight=1
set shortmess=atToO
set showcmd
set laststatus=2
set shiftwidth=8
set backspace=indent,eol,start
set mouse=a
set foldlevel=99
set ic
"set rulerformat=%33(<%-2.2n>\ \ %-5.5l\ [%-5.5L]\ \ %3.3c-%-3.3v\ \ %P%)
set statusline=%<%t\ %y%m%r\ %=%{&ic?'case':'CaSe'}\ [%-5.5L]\ %-5.5l\ %-3.3c%V\ %P
set titlestring=%t\ (%F)%<
set virtualedit=block
set scroll=4
set iskeyword=@,48-57,_,192-255
set updatetime=1000
set scrolloff=3
set spelllang=en_gb

set printoptions=paper:a4,number:y,left:5pc,right:5pc,top:5pc,bottom:5pc
set printheader=%<%t\ %m\ %y%=Page\ %N
set printfont=:h8

" Make shift-K search for keyword on Google.
set keywordprg=search.sh

" Control what state is saved in the viminfo file
set viminfo=%30,'50,<1000,s100,h

" Store swap files on a local disk
if isdirectory($HOME."/local/vimswap")
  set dir=$HOME/local/vimswap
endif

" And some global options
"
"  incsearch       -> Make pattern searching incremental (Handy!)
"  expandtab       -> Convert tabs to spaces (no grim tabs in source for me!)
"  tagrelative     -> Search for files in tag file relative to tag file's dir
"  hidden          -> Allow windows to be hidden by default (instead of closed)
"  wildmenu        -> Tab-completion opens a menu rather than cycling
"  title           -> Update terminal title bar
"  ruler           -> Enable ruler above statusline

set incsearch expandtab tagrelative hidden wildmenu title


" Add menu support and map F1 to pop up the menu
source $VIMRUNTIME/menu.vim
set cpo-=<
set wcm=<C-Z>
map <F1> :emenu <C-Z>

" Enable :Man command.
source $VIMRUNTIME/ftplugin/man.vim


" Read misc. functions.
source $HOME/.vim/andy_functions.vim

" Read key mappings.
source $HOME/.vim/andy_mappings.vim

" Read auto commands.
source $HOME/.vim/andy_autocommands.vim


" Set up autoloading of syntax file.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  map <F12> :silent noh<CR>
endif

" Customise XML mode.
let xml_use_xhtml = 1

" External Tlist plugin.
let Tlist_Sort_Type = "name"
let Tlist_Use_Horiz_Window = 1

" Set default colour scheme
colorscheme andy

" Make left/right cursors work in SQL mode!
let g:omni_sql_no_default_maps = 1

" Set up P4HOME for Perforce plugin and enable various aspects.
if exists("$P4HOME")
  let g:p4ClientRoot = $P4HOME
  runtime perforce/perforceutils.vim
  runtime perforce/perforcemenu.vim
  set titlestring=%t\ %{perforce#RulerStatus()}\ (%F)%<
else
  let loaded_perforce=1
endif

" Read .localvimrc if it exists.
if filereadable($HOME."/.localvimrc")
  source $HOME/.localvimrc
endif

" Activate pathogen.
call pathogen#infect()

" Finally we activate filetype plugins - we do that all the way down here so
" any customisations above can take effect
filetype plugin on

