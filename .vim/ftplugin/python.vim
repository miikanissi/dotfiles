" vim conf for python
" source: https://www.youtube.com/watch?v=Gs1VDYnS-Ac by Leeren

" pep8 style indents and columns
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
setlocal colorcolumn=80

setlocal path=.,**
setlocal wildignore=*.pyc

" pia regex to include pattern for search
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\($\\\| as\\)
" import conv.metrics (1)
" /conv.metrics/
" conv/metrix.py
" from conv import conversion as conv(2)
" /conv import conversion/
" conv/conversion.py conv.py
function! PyInclude(fname)
    let parts = split(a:fname, ' import ') " (1) [conv.metrics] (2) [conv, conversion]
    let l = parts[0] " (1) conv.metrics (2) conv
    if len(parts) > 1
        let r = parts[1] "conversion
        let joined = join([l, r], '.') "conv.conversion
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
