
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
"  backspace       -> Specifies how much backspacing is allowed
"  cinoptions      -> C indentation style, see 'help cinoptions-values'
"  cmdheight       -> Lines used for status bar at base of screen
"  errorformat     -> Used to pick out errors in compiler output
"  foldlevel       -> How many levels of fold to fold
"  formatoptions   -> See 'help fo-table' for details
"  iskeyword       -> Characters which are valid in keywords
"  laststatus      -> When last window has status bar
"  listchars       -> Characters to use in list mode (display tabs, etc..)
"  mouse           -> In which modes the mouse is enabled
"  printfont       -> Sets the font style and size for :hardcopy
"  printheader     -> Controls the page header for :hardcopy
"  printoptions    -> Control the output format of :hardcopy
"  scroll          -> Number of lines to scroll for CTRL+U and CTRL+D
"  scrolloff       -> Lines of context to keep visible either side of cursor
"  shiftwidth      -> Default indentation depth (can be overridden)
"  shortmess       -> Sets abbreviations to use to shorten status messages
"  spelllang       -> Language for spell checking (:set spell)
"  statusline      -> Format string for the status line
"  tags            -> Locations to search for tag file
"  titlestring     -> Format string for window title bar
"  updatetime      -> Time spent idle (in ms) before swap file written
"  virtualedit     -> In which modes to allow the cursor to go off the line

set backspace=indent,eol,start
set cinoptions=:0,=s,l1,g0,p0.5s,t0,+s,cs,(0,u0,j1
set cmdheight=1
set errorformat=%f:%l:%c:\ %m,%f:\ %m
set foldlevel=99
set formatoptions=tcqrl
set iskeyword=@,48-57,_,192-255
set laststatus=2
set listchars=tab:>-,trail:_,extends:<,precedes:>
set mouse=a
set printfont=:h8
set printheader=%<%t\ %m\ %y%=Page\ %N
set printoptions=paper:a4,number:y,left:5pc,right:5pc,top:5pc,bottom:5pc
set scroll=4
set scrolloff=3
set shiftwidth=8
set shortmess=atToO
set spelllang=en_gb
set statusline=%<%t\ %y%m%r\ %=%{&ic?'case':'CaSe'}\ [%-5.5L]\ %-5.5l\ %-3.3c%V\ %P
set tags=./tags,./../tags,./../../tags,./../../../tags
set titlestring=%t\ (%F)%<
set updatetime=1000
set virtualedit=block

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
"  ic              -> Set to ignore case when searching
"  showcmd         -> Show information about current cmd at bottom of screen

set incsearch expandtab tagrelative hidden wildmenu title ic showcmd


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

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" To boostrap:
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"   :BundleInstall

" Github
" vundle
Bundle 'gmarik/vundle'
" file-line
Bundle 'bogado/file-line'
" fugitive
Bundle 'tpope/vim-fugitive'
" gist-vim
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
" syntastic
Bundle 'scrooloose/syntastic'
" taglisttoo
Bundle 'ervandew/taglisttoo'
" vim-session
Bundle 'xolox/vim-session'
" vim-templ
Bundle 'Cartroo/vim-templ'
" xmledit
Bundle 'sukima/xmledit'

" vim-scrips
" bufexplorer
Bundle 'bufexplorer.zip'
" FSwitch
Bundle 'FSwitch'
" Lots of yummy Python goodness
Bundle 'vim-scripts/python.vim'
" PEP8 Python indentation
Bundle 'hynek/vim-python-pep8-indent'

" Finally we activate filetype plugins - we do that all the way down here so
" any customisations above can take effect
filetype plugin indent on

