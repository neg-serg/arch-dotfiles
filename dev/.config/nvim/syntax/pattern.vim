" !::exe [setf vim | so %]

let b:pattern_syntax = 1

syn region v_group matchgroup=patternDelimiter start=/(/ end=/)/ transparent contained
syn region m_group matchgroup=patternDelimiter start=/\\(/ end=/)/ transparent contained
syn region v_range matchgroup=patternDelimiter start=/\[/ end=/]/ contained
syn region m_range matchgroup=patternDelimiter start=/\\\[/ end=/]/ contained

syn match patternFlag    /\v\\[cC]/ contained
syn match patternSpecial /\v[$^]/   contained

syn match v_quantifier     /?\|+\|=\|\*\|\v\{-?\d*,?\d*}/    contained
syn match m_quantifier     /\*\|\\\[?=+]/ contained

syn match v_opt  /\v\%\[.+]/ contained

syn match v_pos  /\v\%(\^|\$|V|#|.m|\d+[lcv])/ contained

syn match v_zerowidth  /\v\@\>|\@\=|\@!|\@\<[!=]/ contained

syn match v_boundary /<\|>/ contained
syn match v_special     /\v[.$^~<>]/ contained
"syn cluster v_escaped  contains=v_zerowidth,v_pos,v_range
"syn match   v_escape   /\v\\/ contained nextgroup=@v_escaped

syn match   m_special   /\v[.$^]/ contained
syn cluster m_escaped contains=v_zerowidth,v_pos,v_range,v_opt,v_group,v_quantifier,v_boundary
syn match   m_escape  /\v\\/ contained nextgroup=@m_escaped

syn match nm_special    /\v[$]/ contained
"syn match nv_special    /\[$]/ contained

syn match _nth       /\v\\[0-9]/                          contained
syn match _char      /\v\\[etrbn]/                        contained
syn match _charClass /\v\\_?[iIkKfFpPsSdDxXoOwWhHaAlLuU]/ contained
syn match _zmatch    /\v\\z[0-9se]/                       contained

syn region patternDefault start='^' end='\v\_$|\\[vVmM]'me=s-1 transparent contained
            \ contains=_nth_char,_charClass,m_escape,m_special
syn region patternVeryMagic   matchgroup=patternFlag start='\\v' end='\v/|\_$|\\[vVmM]'me=s-1 transparent contained
            \ contains=_nth,_char,_charClass,v_opt,v_pos,v_zerowidth,v_special,v_quantifier,v_special,v_group,v_range,v_boundary
syn region patternMagic       matchgroup=patternFlag start='\\m' end='\v/|\_$|\\[vVmM]'me=s-1 transparent contained
            \ contains=_nth_char,_charClass,m_escape,m_special
syn region patternNomagic     matchgroup=patternFlag start='\\M' end='\v/|\_$|\\[vVmM]'me=s-1 transparent contained
            \ contains=_nth,_char,_charClass,m_escape,nm_special
syn region patternVeryNomagic matchgroup=patternFlag start='\\V' end='\v/|\_$|\\[vVmM]'me=s-1 transparent contained
            \ contains=_nth,char,_charClass,m_pos,m_zerowidth,patternChar,patternCharClass

syn cluster patterns contains=
            \_nth_char,_charClass,m_escape,m_special,
            \patternVeryMagic,patternMagic,patternNomagic,patternVeryNomagic

" pattern:\v(\whello)? at%10lcursor>  %#and@= .{2} .* [^range]$
" pattern:\m(\whello)? at\%10lcursor\> and\@= .\{2}  .* [^range]$
" pattern:  (\whello)? at\%10lcursor\> and    .{2}  .* [^range]$
" pattern:\M(\whello)? at\%10lcursor and    .{2}  .* [^range]$
" pattern:\V(\whello)? at\%10lcursor and    .{2}  .* [^range]$

if get(b:, 'current_syntax', 'pattern') == 'vim'
    syn region pattern start=/pattern:/ms=e+1 end=/\_$\|\n/ contains=@patterns keepend
    syn cluster vimCommentGroup add=pattern
else
    syn region pattern start=/\_^/ms=e end=/\_$\|\n/ contains=@patterns keepend
end

hi! link pattern          RegexpText
hi! link patternFlag      RegexpFlag
hi! link patternDelimiter RegexpDelimiter
hi! link _char      RegexpSpecial
hi! link _charClass RegexpSpecial
hi! link v_range     RegexpRange
hi! link m_range     RegexpRange
hi! link m_quantifier RegexpQuantifier
hi! link v_quantifier RegexpQuantifier
hi! link patternQuantifierChar RegexpQuantifier
