" Filetype plugin for editing CSV files.
" Version 2011-11-02 from http://vim.wikia.com/wiki/csv
if v:version < 700 || exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Return number of characters (not bytes) in string.
function! s:CharLen(str)
  return strlen(substitute(a:str, '.', 'x', 'g'))
endfunction

" Display a warning message.
function! s:Warn(msg)
  echohl WarningMsg
  echo a:msg
  echohl NONE
endfunction

" --- Highlighting a column {{{
" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

"}}}
" Set or show column delimiter.
" Accept '\t' (2 characters: backslash, t) as the tab character.
function! s:Delimiter(delim)
  if !empty(a:delim)
    let want = a:delim == '\t' ? "\t" : a:delim
    if s:CharLen(want) != 1
      call s:Warn('Delimiter must be a single character')
      return
    endif
    let b:csv_delimiter = want
  endif
  let b:changed_done = -1
  let b:csv_column = 1
  silent call s:Highlight(b:csv_column)
  echo printf('Delimiter = "%s"', b:csv_delimiter == "\t" ? '\t' : strtrans(b:csv_delimiter))
endfunction
command! -buffer -nargs=? Delimiter call s:Delimiter('<args>')

" Get string containing delimiter (default ',') specified for current buffer.
" A command like ':let g:csv_delimiter = ";"' changes the default.
" Script assumes 'magic' option is in effect, so some special processing
" is needed for some delimiters like '~' and '*'.
" An alternative would be to use '\V' in patterns, but that would be tricky
" given that the "search" patterns are combined with user-entered patterns.
function! s:GetStr(id)
  if !exists('b:csv_delimiter') || empty(b:csv_delimiter)
    if exists('g:csv_delimiter') && !empty(g:csv_delimiter)
      let b:csv_delimiter = g:csv_delimiter
    else
      let b:csv_delimiter = ','
    endif
  endif
  if !exists('b:csv_str')
    let b:csv_str = {'delim': ''}
  endif
  if b:csv_str['delim'] !=# b:csv_delimiter
    " Define strings using delimiter ',' then substitute if required.
    let b:csv_str['delim'] = ','
    let b:csv_str['numco'] = '\%(\%("\%([^"]\|""\)*"\)\|\%([^,"]*\)\)'
    let b:csv_str['expr1'] = '\%(\%("\zs\%([^"]\|""\)*\ze"\)\|\%(\zs[^,"]*\ze\)\)'
    let b:csv_str['expr2'] = '\%(\%(\zs"\%([^"]\|""\)*",\?\ze\)\|\%(\zs[^,"]*,\?\ze\)\)'
    let b:csv_str['expr3'] = '^\%(\%(\%("\%([^"]\|""\)*"\)\|\%([^,"]*\)\),\)\{'
    let b:csv_str['delco'] = ',$'
    let b:csv_str['sear1'] = '^\%(\%("\%([^,]\|""\)*\zs'
    let b:csv_str['sear2'] = '\ze\%([^,]\|""\)*"\)\|\%([^,"]*\zs'
    let b:csv_str['sear3'] = '\ze[^,"]*\)\)'
    let b:csv_str['sear4'] = '^\%(\%(\%("\%([^"]\|""\)*"\)\|\%([^,"]*\)\),\)\{'
    let b:csv_str['sear5'] = '}\%(\%("\%([^,]\|""\)*\zs'
    if b:csv_delimiter != ','
      let d1 = b:csv_delimiter  " d1 replaces ',' in '[...]'
      let d2 = d1               " d2 replaces ',' not in '[...]'
      if d1 == '&'
        let d1 = '\&'           " '&' after substitute()
        let d2 = '\&'           " '&'
      elseif d1 == '['
        let d1 = '\['           " '['
        let d2 = '\\['          " '\['
      elseif d1 == '\'
        let d1 = '\\'           " '\'
        let d2 = '\\\\'         " '\\'
      elseif stridx('.*$^~', d1) >= 0
        let d2 = '\\'.d1        " '\'.d1
      endif
      for key in keys(b:csv_str)
        if key == 'delim'
          let b:csv_str[key] = b:csv_delimiter
        else
          let replace = substitute(b:csv_str[key], '\[[^]]*\zs,', d1, 'g')
          let b:csv_str[key] = substitute(replace, ',', d2, 'g')
        endif
      endfor
    endif
  endif
  return b:csv_str[a:id]
endfunction

" Get the number of columns
" Optionally takes one parameter, a specified line number
function! s:GetNumCols(...)
  let b:csv_max_col = 1
  " if a line number was provided we will examine that ...
  if a:0 == 1
      let rg_cols_to_check = a:000
   " ... else we will default to the maximum of number in first and last three
   " lines; at least one of them should contain typical csv data
  else
      let rg_cols_to_check = [1, 2, 3, line('$')-2, line('$')-1, line('$')]
  endif

  for l in rg_cols_to_check
    " Determine number of columns by counting the (unescaped) delimiters.
    " Note: The regexp may also return unbalanced ", so filter out anything
    " which isn't a delimiter in the second pass.
    let c = s:CharLen(substitute(substitute(getline(l), s:GetStr('numco'), '', 'g'), '"', '', 'g')) + 1
    if b:csv_max_col < c
      let b:csv_max_col = c
    endif
  endfor
  if b:csv_max_col <= 1
    let b:csv_max_col = 999
    call s:Warn('No delimiter-separated columns were detected')
  endif
  return b:csv_max_col
endfunction

" Return regex to find the n-th column.
function! s:GetExpr(colnr, ...)
  if a:0 == 0  " field only
    let field = s:GetStr('expr1')
  else  " field with quotes (if present) and trailing delimiter (if present)
    let field = s:GetStr('expr2')
  endif
  if a:colnr > 1
    return s:GetStr('expr3') . (a:colnr - 1) . '}' . field
  else
    return '^' . field
  endif
endfunction

" Default column header line is the first line
let b:csv_heading_line_number=1

" Extract and echo the column header on the status line.
function! s:PrintColumnInfo(colnr)
  let colHeading = substitute(matchstr(getline(b:csv_heading_line_number), s:GetExpr(a:colnr)),
    \ '^\s*\(.*\)\s*$', '\1', '')
  let info = 'Column ' . a:colnr
  if empty(colHeading)
    echo info
  else
    echon info . ': '
    echohl Type
    " Limit length to avoid "Hit ENTER" prompt.
    echon strpart(colHeading, 0, (&columns / 2)) . (len(colHeading) > (&columns / 2) ? '...' : '')
    echohl NONE
  endif
endfunction

" Change csv_heading_line_number to specified line.
" If no line is specified, use the current line.
function! s:SetHeadinglineNumber(linenr)
  if empty(a:linenr)
    let b:csv_heading_line_number = line('.')
  else
    let b:csv_heading_line_number = a:linenr
  endif
  " Update the displayed column name to use the new heading line
  call s:PrintColumnInfo(b:csv_column)
  " Update the maximum number of columns based on heading
  " line
  call s:GetNumCols(b:csv_heading_line_number)
endfunction
command! -buffer -nargs=? HL call s:SetHeadinglineNumber('<args>')

" Highlight n-th column (if n > 0).
" Remove previous highlight match (ignore error if none).
" matchadd() priority -1 means 'hlsearch' will override the match.
function! s:Highlight(colnr)
  silent! call matchdelete(b:csv_match)
  if a:colnr > 0
    if exists('*matchadd')
      let b:csv_match = matchadd('Keyword', s:GetExpr(a:colnr), -1)
    else
      execute '2match Keyword /' . s:GetExpr(a:colnr) . '/'
    endif
    if b:changed_done != b:changedtick
      let b:changed_done = b:changedtick
      call s:GetNumCols()
    endif
    call s:Focus_Column(a:colnr)
  endif
endfunction

" Focus the cursor on the n-th column of the current line.
function! s:Focus_Column(colnr)
  normal! 0
  call search(s:GetExpr(a:colnr), '', line('.'))
  call s:PrintColumnInfo(a:colnr)
endfunction

" Highlight next column.
function! s:HighlightNextColumn()
  if b:csv_column < b:csv_max_col
    let b:csv_column += 1
  endif
  call s:Highlight(b:csv_column)
endfunction

" Highlight previous column.
function! s:HighlightPrevColumn()
  if b:csv_column > 1
    let b:csv_column -= 1
  endif
  call s:Highlight(b:csv_column)
endfunction

" Highlight the column the cursor is on
function! s:Focus_Cursor()
  let b:csv_column = s:CharLen(substitute(substitute(getline(".")[:col(".")-1], s:GetStr('numco'), '', 'g'), '"', '', 'g')) + 1
  call s:Highlight(b:csv_column)
endfunction
" Wrapping would distort the column-based layout.
" Lines must not be broken when typed.
setlocal nowrap textwidth=0
" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal wrap< textwidth<"
    \ . "|if exists('*matchdelete')|call matchdelete(b:csv_match)|else|2match none|endif"
    \ . "|sil! exe 'nunmap <buffer> H'"
    \ . "|sil! exe 'nunmap <buffer> L'"
    \ . "|sil! exe 'nunmap <buffer> J'"
    \ . "|sil! exe 'nunmap <buffer> K'"
    \ . "|sil! exe 'nunmap <buffer> <C-f>'"
    \ . "|sil! exe 'nunmap <buffer> <C-b>'"
    \ . "|sil! exe 'nunmap <buffer> 0'"
    \ . "|sil! exe 'nunmap <buffer> $'"
    \ . "|sil exe 'augroup csv' . bufnr('')"
    \ . "|sil exe 'au!'"
    \ . "|sil exe 'augroup END'"

let b:changed_done = -1
" Highlight the first column, but not if reloading or resetting filetype.
if !exists('b:csv_column')
  let b:csv_column = 1
endif
" Following highlights column and calls GetNumCols() if set filetype manually
" (BufEnter will also do it if filetype is set during load).
silent call s:Highlight(b:csv_column)

" Return Float value of field in line selected by regex, or the String field.
function! s:GetValue(line, regex)
  let field = matchstr(a:line, a:regex)
  let val = str2float(field)
  if val == 0 && match(field, '^0*\.\?0*$') < 0
    return field
  endif
  return val
endfunction

" Compare lines based on the floating point values in the specified column.
" This uses string compare 'ignorecase' option if neither field is a float.
function! s:CompareLines(line1, line2)
  let val1 = s:GetValue(a:line1, b:csv_sort_regex)
  let val2 = s:GetValue(a:line2, b:csv_sort_regex)
  if type(val1) != type(val2)
    let val1 = type(val1)
    let val2 = type(val2)
  endif
  let ascending = val1 > val2 ? 1 : val1 < val2 ? -1 : 0
  return b:csv_sort_ascending ? ascending : -ascending
endfunction

" Sort the n-th column, the highlighted one by default.
" If range_given is non-zero we use line1 and line2,
" otherwise they are ignored.  Range_given is given the
" value of <count> below
" Column number is first optional arg; following are flags for :sort.
function! s:SortColumn(bang, range_given, line1, line2, ...) range
  let colnr = b:csv_column
  let args = copy(a:000)
  if len(args) > 0 && args[0] =~ '^\d\+$'
    let colnr = str2nr(args[0])
    unlet args[0]
  endif
  if colnr < 1 || colnr > b:csv_max_col
    call s:Warn('Column number out of range')
  endif

  "First check that the headings line is a valid line
  if b:csv_heading_line_number >= line('$')
    call s:Warn('No lines to sort - specified heading line ['.b:csv_heading_line_number.
      \ '] is at or beyond end of file')
    return 1
  endif

  "Work out the first line to start sorting at.
  "If they explicitly passed a range, use it
  "else use from line after heading line to $
  "(if they turned off the heading line with HL 0,
  " this will cover the whole buffer)
  if a:range_given
    let first = a:line1
    let last = a:line2
  else
    let first = b:csv_heading_line_number + 1
    let last = line('$')
  endif

  let flags = join(args)
  if flags == 'f'
    let b:csv_sort_ascending = empty(a:bang)
    let b:csv_sort_regex = s:GetExpr(colnr)
    call setline(first, sort(getline(first, last), function('s:CompareLines')))
  else
    let cmd = first.','.last.'sort'.a:bang
    execute cmd 'r'.flags '/'.escape(s:GetExpr(colnr), '/').'/'
  endif
endfunction
command! -bang -buffer -nargs=* -range=0 Sort call s:SortColumn('<bang>', <count>, <line1>, <line2>, <f-args>)

" Copy an entire column into a register.
" Column number can be omitted (default is the current column).
" Register is a-z, or A-Z (append), or omitted for the unnamed register.
" Example: ':CC 12 b' copies column 12 into register b.
function! s:CopyColumn(args)
  let l = matchlist(a:args, '^\(\d*\)\s*\(\a\)\?$')
  if len(l) < 3
    call s:Warn('Invalid arguments (need column_number register)')
    return
  endif
  let col = empty(l[1]) ? b:csv_column : str2nr(l[1])
  let reg = empty(l[2]) ? '@' : l[2]
  if col < 1 || col > b:csv_max_col
    call s:Warn('Column number out of range')
    return
  endif
  let matchcol = s:GetExpr(col)
  let cells = []
  for lnum in range(1, line('$'))
    call add(cells, matchstr(getline(lnum), matchcol))
  endfor
  execute 'let @'.reg.' = join(cells, "\n")."\n"'
endfunction
command! -buffer -nargs=* CC call s:CopyColumn('<args>')

" Delete the n-th column, the highlighted one by default.
function! s:DeleteColumn(colnr)
  if empty(a:colnr)
    let col = b:csv_column
  else
    let col = str2nr(a:colnr)
  endif
  if col < 1 || col > b:csv_max_col
    call s:Warn('Column number out of range')
  endif
  execute '%s/'.escape(s:GetExpr(col, 1), '/').'//'
  if col == b:csv_max_col
    execute 'silent %s/'.escape(s:GetStr('delco'), '/').'//e'
  endif
  let b:csv_max_col -= 1
  if b:csv_column > b:csv_max_col
    call s:HighlightPrevColumn()
  endif
endfunction
command! -buffer -nargs=? DC call s:DeleteColumn('<args>')

" Search the n-th column. Argument in n=regex form where n is the column
" number, and regex is the expression to use. If "n=" is omitted, then
" use the current highlighted column.
function! s:SearchColumn(args)
  let [colstr, target] = matchlist(a:args, '\%(\([1-9][0-9]*\)=\)\?\(.*\)')[1:2]
  if empty(colstr)
    let col = b:csv_column
  else
    let col = str2nr(colstr)
  endif
  if col < 1 || col > b:csv_max_col
    call s:Warn('Column number out of range')
  endif
  if col == 1
    let @/ = s:GetStr('sear1').target.s:GetStr('sear2').target.s:GetStr('sear3')
  else
    let @/ = s:GetStr('sear4').(col-1).s:GetStr('sear5').target.s:GetStr('sear2').target.s:GetStr('sear3')
  endif
endfunction
" Use :SC n=string<CR> to search for string in the n-th column
command! -buffer -nargs=1 SC execute s:SearchColumn('<args>')|normal! n

nnoremap <silent> <buffer> <space> :call <SID>Focus_Cursor()<CR>
nnoremap <silent> <buffer> H :call <SID>HighlightPrevColumn()<CR>
nnoremap <silent> <buffer> L :call <SID>HighlightNextColumn()<CR>
nnoremap <silent> <buffer> J <Down>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> K <Up>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> <C-f> <PageDown>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> <C-b> <PageUp>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> <C-d> <C-d>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> <C-u> <C-u>:call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> 0 :let b:csv_column=1<CR>:call <SID>Highlight(b:csv_column)<CR>
nnoremap <silent> <buffer> $ :let b:csv_column=b:csv_max_col<CR>:call <SID>Highlight(b:csv_column)<CR>
nnoremap <silent> <buffer> gm :call <SID>Focus_Column(b:csv_column)<CR>
nnoremap <silent> <buffer> <LocalLeader>J J
nnoremap <silent> <buffer> <LocalLeader>K K

" The column highlighting is window-local, not buffer-local, so it can persist
" even when the filetype is undone or the buffer changed.
execute 'augroup csv' . bufnr('')
  autocmd!
  " These events only highlight in the current window.
  " Note: Highlighting gets slightly confused if the same buffer is present in
  " two split windows next to each other, because then the events aren't fired.
  autocmd BufLeave <buffer> silent call s:Highlight(0)
  autocmd BufEnter <buffer> silent call s:Highlight(b:csv_column)
augroup END
