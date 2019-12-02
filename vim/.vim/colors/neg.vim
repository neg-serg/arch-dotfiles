" Name:        neg
" Version:     1.4
" Last Change: 02-11-2019
" Maintainer:  Sergey Miroshnichenko <serg.zorg@gmail.com>
" URL:         
" About:       neg theme extends Jason W Ryan's miromiro(1) Vim color file

set background=dark
hi clear
if exists('syntax on')
    syntax reset
endif

let s:bclr='#000000'        " background color hexadecimal
let s:dblk='#121212'        " dark black hexadecimal    (color 0)
let s:lblk='#3d3d3d'        " light black hexadecimal   (color 8)
let s:dred='#8a2f58'        " dark red hexadecimal      (color 1)
let s:lred='#cf4f88'        " light red hexadecimal     (color 9)
let s:dgrn='#297480'        " dark green hexadecimal    (color 2)
let s:lgrn='#53a6a6'        " light green hexadecimal   (color 10)
let s:dylw='#914e89'        " dark yellow hexadecimal   (color 3)
let s:lylw='#bf85cc'        " light yellow hexadecimal  (color 11)
let s:dblu='#395573'        " dark blue hexadecimal     (color 4)
let s:lblu='#4779b3'        " light blue hexadecimal    (color 12)
let s:dmag='#5e468c'        " dark magentahexadecimal   (color 5)
let s:lmag='#7f62b3'        " light magenta hexadecimal (color 13)
let s:dcyn='#2b7694'        " dark cyan hexadecimal     (color 6)
let s:lcyn='#47959e'        " light cyan hexadecimal    (color 14)
let s:dwht='#899ca1'        " dark white hexadecimal    (color 7)
let s:lwht='#c0c0c0'        " light white hexadecimal   (color 15)
let s:culc='#272727'        " cursor line/column hexadecimal
let s:color233='#040404'    " (color 233)
let s:color30='#008787'     " (color 30)
let s:color31='#0087AF'     " (color 31)
let s:color32='#002B36'     " (color 32)
let s:color222='#5C9CAA'    " (color 222)
let s:color225='#25533F'    " (color 225)
let s:color250='#666666'    " (color 250)
let s:color251='#AFA0F0'    " (color 251)
let s:color89='#232030'     " (color 89)
let s:color62='#002B36'     " (color 62)
let s:color234='#080808'    " (color 234)
let s:color227='#006D39'    " (color 227)
let s:color228='#00406D'    " (color 228)
let s:color162='#CC6666'    " (color 162)
let s:color127='#5F0000'    " (color 127)
let s:color253='#617287'    " (color 253)
let s:color255='#eeeeee'    " (color 255)
let s:color200='#0C1014'    " (color 200)
let s:colorcursor='#375BC1' " (color cursor)
let s:colorsearch='#005FAF' " (search highlight color)

fun! s:hi(group, bg, fg, attr)
    exec "hi" a:group
         \ . ' ' . (a:bg   != '' ? 'guibg=' . a:bg   : '')
         \ . ' ' . (a:fg   != '' ? 'guifg=' . a:fg   : '')
         \ . ' ' . (a:attr != '' ? 'gui='   . a:attr : '')
endfun

hi Normal guifg=#617287 guibg=NONE

hi! clear DiffAdd
hi! clear DiffAdded
hi! clear DiffRemoved
hi! clear DiffChange
hi! clear DiffDelete
hi! clear DiffText

hi! link DeclRefExpr Normal
hi! link Conceal Operator
hi! link DiffRemoved Constant
hi! link DiffAdded String

call s:hi('Ignore',               '',            s:lblk,        '')
call s:hi('Comment',              '',            s:dwht,        '')
call s:hi('Float',                '',            s:dylw,        '')
call s:hi('Include',              '',            s:dmag,        '')
call s:hi('Define',               '',            s:dgrn,        '')
call s:hi('Macro',                '',            s:lmag,        '')
call s:hi('PreProc',              '',            s:lgrn,        '')
call s:hi('PreCondit',            '',            s:lmag,        '')
call s:hi('NonText',              '',            s:dcyn,        '')
call s:hi('Directory',            '',            s:dcyn,        '')
call s:hi('SpecialKey',           '',            s:lylw,        '')
call s:hi('Type',                 '',            s:dcyn,        '')
call s:hi('String',               '',            '#6F839C',     '')
call s:hi('Constant',             '',            s:lmag,        '')
call s:hi('Special',              '',            s:lgrn,        '')
call s:hi('SpecialChar',          '',            s:color30,     '')
call s:hi('Number',               '',            s:lcyn,        '')
call s:hi('Identifier',           '',            '#6289B3',     '')
call s:hi('Conditional',          '',            s:lcyn,        '')
call s:hi('Repeat',               '',            s:lcyn,        '')
call s:hi('Statement',            '',            s:dblu,        '')
call s:hi('Label',                '',            s:lmag,        '')
call s:hi('Operator',             '',            s:dcyn,        '')
call s:hi('Keyword',              '',            s:dcyn,        '')
call s:hi('StorageClass',         '',            s:color31,     '')
call s:hi('Structure',            '',            s:dmag,        '')
call s:hi('Typedef',              '',            s:dcyn,        '')
call s:hi('Function',             '',            s:color222,    '')
call s:hi('cFunctionTag',         '',            s:color30,     '')
call s:hi('Exception',            '',            s:dred,        '')
call s:hi('Underlined',           '',            s:dblu,        '')
call s:hi('Title',                '',            s:dylw,        '')
call s:hi('Tag',                  '',            s:lylw,        '')
call s:hi('Delimiter',            '',            s:lblu,        '')
call s:hi('SpecialComment',       '',            s:dwht,        'underline')
call s:hi('Boolean',              '',            s:dylw,        '')
call s:hi('Todo',                 'NONE',        s:dred,        '')
call s:hi('MoreMsg',              'NONE',        s:lmag,        '')
call s:hi('ModeMsg',              'NONE',        s:lmag,        '')
call s:hi('Debug',                'NONE',        s:dred,        '')
call s:hi('MatchParen',           s:dwht,        s:dblk,        '')
call s:hi('ErrorMsg',             'NONE',        s:color250,    '')
call s:hi('WildMenu',             s:dblk,        s:dmag,        '')
call s:hi('Folded',               s:color32,     s:dwht,        '')
call s:hi('Search',               s:dblu,        s:dblk,        '')
call s:hi('IncSearch',            s:dblk,        s:colorsearch, 'underline')
call s:hi('WarningMsg',           'NONE',        s:color250,    '')
call s:hi('Question',             'NONE',        s:lgrn,        '')
call s:hi('Visual',               s:color62,     s:dwht,        '')
call s:hi('StatusLine',           'NONE',        s:dblu,        'bold')
call s:hi('StatusLineNC',         'NONE',        'NONE',        'none')
call s:hi('VertSplit',            'NONE',        'NONE',        'none')
call s:hi('TabLine',              s:dblk,        s:dwht,        '')
call s:hi('TabLineFill',          'NONE',        s:dblk,        '')
call s:hi('TabLineSel',           s:dblk,        s:dwht,        '')
call s:hi('Cursor',               s:colorcursor, 'NONE',        'NONE')
call s:hi('CursorLine',           s:color234,    'NONE',        'none')
call s:hi('CursorLineNr',         'NONE',        s:lylw,        'none')
call s:hi('CursorColumn',         s:culc,        'NONE',        '')
call s:hi('ColorColumn',          s:culc,        'NONE',        '')
call s:hi('FoldColumn',           'NONE',        s:lblk,        '')
call s:hi('SignColumn',           'NONE',        'NONE',        '')
call s:hi('DiffAdd',              s:lwht,        s:color225,    '')
call s:hi('DiffChange',           s:lwht,        s:color228,    '')
call s:hi('DiffText',             'NONE',        s:lwht,        '')
call s:hi('DiffDelete',           s:color162,    s:color127,    '')
call s:hi('Error',                s:color162,    s:color127,    '')
call s:hi('Pmenu',                s:color253,    s:bclr,        'reverse')
call s:hi('PmenuSel',             s:colorsearch, s:color200,    'reverse')
call s:hi('PmenuSbar',            s:dblk,        'NONE',        '')
call s:hi('PmenuThumb',           s:dgrn,        'NONE',        '')
call s:hi('vimCommentTitle',      '',            s:lgrn,        '')
call s:hi('vimFold',              s:lwht,        s:dblk,        '')
call s:hi('helpHyperTextJump',    '',            s:lylw,        '')
call s:hi('javaScriptNumber',     '',            s:lylw,        '')
call s:hi('htmlTag',              '',            s:dcyn,        '')
call s:hi('htmlEndTag',           '',            s:dcyn,        '')
call s:hi('htmlTagName',          '',            s:lylw,        '')
call s:hi('perlSharpBang',        '',            s:lgrn,        'standout')
call s:hi('perlStatement',        '',            s:lmag,        '')
call s:hi('perlStatementStorage', '',            s:dred,        '')
call s:hi('perlVarPlain',         '',            s:dylw,        '')
call s:hi('perlVarPlain2',        '',            s:lylw,        '')
call s:hi('rubySharpBang',        '',            s:lgrn,        'standout')
call s:hi('diffLine',             '',            s:lgrn,        '')
call s:hi('diffOldLine',          '',            s:dgrn,        '')
call s:hi('diffOldFile',          '',            s:dgrn,        '')
call s:hi('diffNewFile',          '',            s:dgrn,        '')
call s:hi('diffAdded',            '',            s:dblu,        '')
call s:hi('diffRemoved',          '',            s:dred,        '')
call s:hi('diffChanged',          '',            s:dcyn,        '')
call s:hi('fzf1',                 '',            s:dred,        '')
call s:hi('fzf2',                 '',            s:dylw,        '')
call s:hi('fzf3',                 '',            s:lylw,        '')

if has('spell')
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellRare
    hi clear SpellLocal
    call s:hi('SpellBad', '', '', 'underline')
    call s:hi('SpellCap', '', '', 'underline')
    call s:hi('SpellRare', '', '', 'underline')
    call s:hi('SpellLocal', '', '', 'underline')
endif

call s:hi('SyntasticErrorSign', s:culc, s:lred, '')
call s:hi('SyntasticWarningSign', s:culc, s:lmag, '')

call s:hi('TermCursor', s:colorcursor, 'NONE', 'NONE')
call s:hi('TermCursorNC', s:lblk, 'NONE', 'NONE')

if has('spell')
    hi! clear SpellBad
    hi! clear SpellCap
    hi! clear SpellRare
    hi! clear SpellLocal
endif

syn region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}\|%stopzone\>' contains=@Spell
syn region texZone start='\\begin{minted}' end='\\end{minted}\|%stopzone\>' contains=@Spell

if exists('g:loaded_operator_highlight')
    finish
else
    let g:loaded_operator_highlight = 1
endif

if !exists('g:ophigh_filetypes_to_ignore')
  let g:ophigh_filetypes_to_ignore = {}
endif

fun! s:IgnoreFiletypeIfNotSet(file_type)
  if get( g:ophigh_filetypes_to_ignore, a:file_type, 1)
    let g:ophigh_filetypes_to_ignore[ a:file_type ] = 1
  endif
endfunction

call s:IgnoreFiletypeIfNotSet('help')
call s:IgnoreFiletypeIfNotSet('markdown')
call s:IgnoreFiletypeIfNotSet('qf') " This is for the quickfix window
call s:IgnoreFiletypeIfNotSet('conque_term')
call s:IgnoreFiletypeIfNotSet('diff')
call s:IgnoreFiletypeIfNotSet('html')
call s:IgnoreFiletypeIfNotSet('css')
call s:IgnoreFiletypeIfNotSet('less')
call s:IgnoreFiletypeIfNotSet('xml')
call s:IgnoreFiletypeIfNotSet('tex')
call s:IgnoreFiletypeIfNotSet('notes')
call s:IgnoreFiletypeIfNotSet('jinja')
call s:IgnoreFiletypeIfNotSet('lua')
call s:IgnoreFiletypeIfNotSet('vidir-ls')
call s:IgnoreFiletypeIfNotSet('haskell')
call s:IgnoreFiletypeIfNotSet('text')
call s:IgnoreFiletypeIfNotSet('lisp')

hi link NormalFloat Normal
hi link CocFloating Normal
hi LineNr guifg=#202022 guibg=#040404
