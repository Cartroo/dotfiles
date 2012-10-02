
if has("gui_running")

  " Set inital window size.
  set lines=50 columns=80

  " Set font
  if has("gui_win32")
    "Assume a recent version of Windows (Consolas font is pretty new)
    set guifont=Consolas:h11:cANSI
  endif

endif

