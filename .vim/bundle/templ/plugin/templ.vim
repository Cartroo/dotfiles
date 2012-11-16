"
" Trivial Templating
"
" This Vim plugin allows simple templates to be created in .vim/templates
" and then inserted using the LoadTemplate command, which takes a single
" argument being the filename of the template to load.
"
" Current the following substitutions are performed:
"
"   {UUID}      --> A randomly-generated UUID, suitable for include guards
"   {DT:x}      --> Use "x" as a strftime() format string for the current time
"

if exists("g:templ_plugin_loaded")
    finish
endif
let g_templ_plugin_loaded = 1


let s:default_template_dir = $HOME."/.vim/templates"


function <SID>Replace(src, dst)
    silent! exec "'[,']s@{".a:src."}@\\=\"".escape(a:dst, "\"\\")."\"@g"
endfunction


function <SID>ReplaceTime(pattern)
    silent! exec "'[,']s@{".a:pattern.":\\([^}]*\\)}@\\=strftime(submatch(1))@g"
endfunction


function <SID>Replacements()
    let l:uuid = substitute(matchstr(system("uuidgen"), "[^\n\r]*"), "-", "_", "g")
    call <SID>Replace("UUID", l:uuid)
    call <SID>ReplaceTime("DT")
endfunction


function <SID>LoadTemplate(name)
    let l:template_path = s:default_template_dir."/".a:name
    if filereadable(l:template_path)
        exec "read ++edit ".l:template_path
        call <SID>Replacements()
    endif
endfunction

command -nargs=1 LoadTemplate :call <SID>LoadTemplate("<args>")

