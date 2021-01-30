syn region dosiniSection start="^\[" end="\(\n\+\[\)\@=" contains=dosiniLabel,dosiniHeader,dosiniComment keepend fold
setlocal foldmethod=syntax
" Following opens all folds (remove line to start with folds closed).
setlocal foldlevel=0

syn match  dosinicomment        "^;.*$\|^#.*$"
syn match  dosinilabel          "^\s\+ ="
