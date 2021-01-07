" vim conf for python
" by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
" sources: https://www.youtube.com/watch?v=Gs1VDYnS-Ac

" pep8 style indents and columns
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set fileformat=unix
set foldmethod=indent

setlocal colorcolumn=80
let python_highlight_all=1

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/

setlocal path=.,**
setlocal wildignore=*.pyc

" pia regex to include pattern for search
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\($\\\|\ as\\)
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
