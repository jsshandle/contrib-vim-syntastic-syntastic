"============================================================================
"File:        tcl.vim
"Description: Figures out which tcl syntax checker (if any) to load
"             from the tcl directory.
"Maintainer:  James Pickard <james.pickard at gmail. dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" Use g:syntastic_tcl_checker option to specify which tcl checker executable
" should be used (see below for a list of supported checkers).
" If g:syntastic_tcl_checker is not set, just use the first syntax
" checker that we find installed.
"============================================================================
if exists("loaded_tcl_syntax_checker")
    finish
endif
let loaded_tcl_syntax_checker = 1

let s:supported_checkers = ["tclsh", "nagelfar"]

function! s:load_checker(checker)
    exec "runtime syntax_checkers/tcl/" . a:checker . ".vim"
endfunction

if exists("g:syntastic_tcl_checker")
    if index(s:supported_checkers, g:syntastic_tcl_checker) != -1 && executable(g:syntastic_tcl_checker)
        call s:load_checker(g:syntastic_tcl_checker)
    else
        echoerr "tcl syntax not supported or not installed."
    endif
else
    for checker in s:supported_checkers
        if executable(checker)
            call s:load_checker(checker)
            break
        endif
    endfor
endif
