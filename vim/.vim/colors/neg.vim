" Name:        wim
" Version:     1.0
" Last Change: 06-02-2016
" Maintainer:  Sergey Miroshnichenko <serg.zorg@gmail.com>
" URL:         
" About:       wim extends Jason W Ryan's miromiro(1) Vim color file

let g:mirodark_enable_higher_contrast_mode=1

if !has('gui_running') && (!has('termguicolors') || (has('termguicolors') && !&termguicolors)) && empty($NVIM_TUI_ENABLE_TRUE_COLOR) &&
            \ (&t_Co == 256 && !exists('g:mirodark_disable_color_approximation'))
    fun! s:rgb_color(x, y, z)
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endfun

    fun! s:color(r, g, b)
        return s:rgb_color(l:x, l:y, l:z)
    endfun

    fun! s:rgb(rgb)
        let l:r = ('0x' . strpart(a:rgb, 0, 2)) + 0
        let l:g = ('0x' . strpart(a:rgb, 2, 2)) + 0
        let l:b = ('0x' . strpart(a:rgb, 4, 2)) + 0
        return s:color(l:r, l:g, l:b)
    endfun
endif

set background=dark
hi clear
if exists('syntax on')
    syntax reset
endif

if has('gui_running') || (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR) ||
            \ (&t_Co == 256 && !exists('g:mirodark_disable_color_approximation'))
    let s:conf_bclr_hex='000000'
    let s:conf_dblk_hex='121212'
    let s:conf_lblk_hex='3d3d3d'

    let s:bclr_hex=s:conf_bclr_hex " background color hexadecimal
    let s:fclr_hex='999999'        " foreground color hexadecimal
    let s:dblk_hex=s:conf_dblk_hex " dark black hexadecimal    (color 0)
    let s:lblk_hex=s:conf_lblk_hex " light black hexadecimal   (color 8)
    let s:dred_hex='8a2f58'        " dark red hexadecimal      (color 1)
    let s:lred_hex='cf4f88'        " light red hexadecimal     (color 9)
    let s:dgrn_hex='287373'        " dark green hexadecimal    (color 2)
    let s:lgrn_hex='53a6a6'        " light green hexadecimal   (color 10)
    let s:dylw_hex='914e89'        " dark yellow hexadecimal   (color 3)
    let s:lylw_hex='bf85cc'        " light yellow hexadecimal  (color 11)
    let s:dblu_hex='395573'        " dark blue hexadecimal     (color 4)
    let s:lblu_hex='4779b3'        " light blue hexadecimal    (color 12)
    let s:dmag_hex='5e468c'        " dark magentahexadecimal   (color 5)
    let s:lmag_hex='7f62b3'        " light magenta hexadecimal (color 13)
    let s:dcyn_hex='2b7694'        " dark cyan hexadecimal     (color 6)
    let s:lcyn_hex='47959e'        " light cyan hexadecimal    (color 14)
    let s:dwht_hex='899ca1'        " dark white hexadecimal    (color 7)
    let s:lwht_hex='c0c0c0'        " light white hexadecimal   (color 15)
    let s:culc_hex='272727'        " cursor line/column hexadecimal
    let s:color233_hex='040404'    " (color 233)
    let s:color30_hex='008787'     " (color 30)
    let s:color31_hex='0087AF'     " (color 31)
    let s:color32_hex='002B36'     " (color 32)
    let s:color222_hex='5C9CAA'    " (color 222)
    let s:color225_hex='25533F'    " (color 225)
    let s:color250_hex='666666'    " (color 250)
    let s:color251_hex='AFA0F0'    " (color 251)
    let s:color89_hex='232030'     " (color 89)
    let s:color62_hex='002B36'     " (color 62)
    let s:color234_hex='080808'    " (color 234)
    let s:color227_hex='006D39'    " (color 227)
    let s:color228_hex='00406D'    " (color 228)
    let s:color162_hex='CC6666'    " (color 162)
    let s:color127_hex='5F0000'    " (color 127)
    let s:color253_hex='617287'    " (color 253)
    let s:color255_hex='eeeeee'    " (color 255)
    let s:color200_hex='0C1014'    " (color 200)
    let s:colorcursor_hex='375BC1' " (color cursor)
    let s:colorsearch_hex='005FAF' " (search highlight color)

    if has('gui_running') || (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR)
        let s:venv='gui' " vim environment (term, cterm, gui)
        let s:bclr='#'.s:bclr_hex
        let s:fclr='#'.s:fclr_hex
        let s:dblk='#'.s:dblk_hex
        let s:lblk='#'.s:lblk_hex
        let s:dred='#'.s:dred_hex
        let s:lred='#'.s:lred_hex
        let s:dgrn='#'.s:dgrn_hex
        let s:lgrn='#'.s:lgrn_hex
        let s:dylw='#'.s:dylw_hex
        let s:lylw='#'.s:lylw_hex
        let s:dblu='#'.s:dblu_hex
        let s:lblu='#'.s:lblu_hex
        let s:dmag='#'.s:dmag_hex
        let s:lmag='#'.s:lmag_hex
        let s:dcyn='#'.s:dcyn_hex
        let s:lcyn='#'.s:lcyn_hex
        let s:dwht='#'.s:dwht_hex
        let s:lwht='#'.s:lwht_hex
        let s:culc='#'.s:culc_hex
        let s:color233='#'.s:color233_hex
        let s:color30='#'.s:color30_hex
        let s:color31='#'.s:color31_hex
        let s:color32='#'.s:color32_hex
        let s:color222='#'.s:color222_hex
        let s:color225='#'.s:color225_hex
        let s:color250='#'.s:color250_hex
        let s:color251='#'.s:color251_hex
        let s:color89='#'.s:color89_hex
        let s:color62='#'.s:color62_hex
        let s:color234='#'.s:color234_hex
        let s:color227='#'.s:color227_hex
        let s:color228='#'.s:color228_hex
        let s:color162='#'.s:color162_hex
        let s:color127='#'.s:color127_hex
        let s:color253='#'.s:color253_hex
        let s:color255='#'.s:color255_hex
        let s:color200='#'.s:color200_hex
        let s:colorcursor='#'.s:colorcursor_hex
        let s:colorsearch='#'.s:colorsearch_hex
    else
        let s:venv="cterm"
        let s:bclr=s:rgb(s:bclr_hex)
        let s:fclr=s:rgb(s:fclr_hex)
        let s:dblk=s:rgb(s:dblk_hex)
        let s:lblk=s:rgb(s:lblk_hex)
        let s:dred=s:rgb(s:dred_hex)
        let s:lred=s:rgb(s:lred_hex)
        let s:dgrn=s:rgb(s:dgrn_hex)
        let s:lgrn=s:rgb(s:lgrn_hex)
        let s:dylw=s:rgb(s:dylw_hex)
        let s:lylw=s:rgb(s:lylw_hex)
        let s:dblu=s:rgb(s:dblu_hex)
        let s:lblu=s:rgb(s:lblu_hex)
        let s:dmag=s:rgb(s:dmag_hex)
        let s:lmag=s:rgb(s:lmag_hex)
        let s:dcyn=s:rgb(s:dcyn_hex)
        let s:lcyn=s:rgb(s:lcyn_hex)
        let s:dwht=s:rgb(s:dwht_hex)
        let s:lwht=s:rgb(s:lwht_hex)
        let s:culc=s:rgb(s:culc_hex)
        let s:color233=s:rgb(s:color233_hex)
        let s:color30=s:rgb(s:color30_hex)
        let s:color31=s:rgb(s:color31_hex)
        let s:color32=s:rgb(s:color32_hex)
        let s:color222=s:rgb(s:color222_hex)
        let s:color225=s:rgb(s:color225_hex)
        let s:color250=s:rgb(s:color250_hex)
        let s:color251=s:rgb(s:color251_hex)
        let s:color89=s:rgb(s:color89_hex)
        let s:color62=s:rgb(s:color62_hex)
        let s:color234=s:rgb(s:color234_hex)
        let s:color227=s:rgb(s:color227_hex)
        let s:color228=s:rgb(s:color228_hex)
        let s:color162=s:rgb(s:color162_hex)
        let s:color127=s:rgb(s:color172_hex)
        let s:color253=s:rgb(s:color253_hex)
        let s:color255=s:rgb(s:color255_hex)
        let s:color200=s:rgb(s:color200_hex)
        let s:colorcursor=s:rgb(s:colorcursor_hex)
        let s:colorsearch=s:rgb(s:colorsearch_hex)
    endif
elseif $TERM == 'linux'
    let s:venv='cterm'
    let s:bclr=''
    let s:fclr=''
    let s:dblk='Black'
    let s:lblk='DarkGray'
    let s:dred='DarkRed'
    let s:lred='LightRed'
    let s:dgrn='DarkGreen'
    let s:lgrn='LightGreen'
    let s:dylw='DarkYellow'
    let s:lylw='LightYellow'
    let s:dblu='DarkBlue'
    let s:lblu='LightBlue'
    let s:dmag='DarkMagenta'
    let s:lmag='LightMagenta'
    let s:dcyn='DarkCyan'
    let s:lcyn='LightCyan'
    let s:dwht='LightGray'
    let s:lwht='White'
    let s:culc=s:dblk
    let s:colorsearch='DarkCyan'
else
    let s:venv='cterm'
    let s:bclr=''
    let s:fclr=''
    let s:dblk='0'
    let s:lblk='8'
    let s:dred='1'
    let s:lred='9'
    let s:dgrn='2'
    let s:lgrn='10'
    let s:dylw='3'
    let s:lylw='11'
    let s:dblu='4'
    let s:lblu='12'
    let s:dmag='5'
    let s:lmag='13'
    let s:dcyn='6'
    let s:lcyn='14'
    let s:dwht='7'
    let s:lwht='15'
    let s:culc='235'
    let s:color233='233'
    let s:color30='30'
    let s:color31='31'
    let s:color32='32'
    let s:color222='222'
    let s:color225='225'
    let s:color250='250'
    let s:color251='251'
    let s:color89='89'
    let s:color62='62'
    let s:color234='234'
    let s:color228='228'
    let s:color227='227'
    let s:color162='162'
    let s:color127='127'
    let s:color253='253'
    let s:color255='255'
    let s:color200='200'
    let s:colorcursor='4'
    let s:colorsearch='221'
endif

fun! s:HI(group, bg, fg, attr)
    exec "hi" a:group
                \ . ' ' . (a:bg   != '' ? s:venv . 'bg=' . a:bg   : '')
                \ . ' ' . (a:fg   != '' ? s:venv . 'fg=' . a:fg   : '')
                \ . ' ' . (a:attr != '' ? s:venv . '='   . a:attr : '')
endfun

if !exists("g:gui_oni")
    call s:HI(         'Normal', 'NONE', 'NONE', 'NONE' )
else
    hi Normal guifg=#617287 guibg=NONE
endif

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

call s:HI(         'Ignore',     '', s:lblk,             '' )
call s:HI(        'Comment',     '', s:dwht,             '' )
call s:HI(         'LineNr',     s:color233, s:lblk,     '' )
call s:HI(          'Float',     '', s:dylw,             '' )
call s:HI(        'Include',     '', s:dmag,             '' )
call s:HI(         'Define',     '', s:dgrn,             '' )
call s:HI(          'Macro',     '', s:lmag,             '' )
call s:HI(        'PreProc',     '', s:lgrn,             '' )
call s:HI(      'PreCondit',     '', s:lmag,             '' )
call s:HI(        'NonText',     '', s:dcyn,             '' )
call s:HI(      'Directory',     '', s:dcyn,             '' )
call s:HI(     'SpecialKey',     '', s:lylw,             '' )
call s:HI(           'Type',     '', s:dcyn,             '' )
call s:HI(         'String',     '', s:dgrn,             '' )
call s:HI(       'Constant',     '', s:lmag,             '' )
call s:HI(        'Special',     '', s:lgrn,             '' )
call s:HI(    'SpecialChar',     '', s:color30,          '' )
call s:HI(         'Number',     '', s:lcyn,             '' )
call s:HI(     'Identifier',     '', s:lmag,             '' )
call s:HI(    'Conditional',     '', s:lcyn,             '' )
call s:HI(         'Repeat',     '', s:lcyn,             '' )
call s:HI(      'Statement',     '', s:dblu,             '' )
call s:HI(          'Label',     '', s:lmag,             '' )
call s:HI(       'Operator',     '', s:dcyn,             '' )
call s:HI(        'Keyword',     '', s:dcyn,             '' )
call s:HI(   'StorageClass',     '', s:color31,          '' )
call s:HI(      'Structure',     '', s:dmag,             '' )
call s:HI(        'Typedef',     '', s:dcyn,             '' )
call s:HI(       'Function',     '', s:color222,         '' )
call s:HI(   'cFunctionTag',     '', s:color30,          '' )
call s:HI(      'Exception',     '', s:dred,             '' )
call s:HI(     'Underlined',     '', s:dblu,             '' )
call s:HI(          'Title',     '', s:dylw,             '' )
call s:HI(            'Tag',     '', s:lylw,             '' )
call s:HI(      'Delimiter',     '', s:lblu,             '' )
call s:HI( 'SpecialComment',     '', s:dwht,             'underline' )
call s:HI(        'Boolean',     '', s:dylw,             '' )
call s:HI(           'Todo', 'NONE', s:dred,             '' )
call s:HI(        'MoreMsg', 'NONE', s:lmag,             '' )
call s:HI(        'ModeMsg', 'NONE', s:lmag,             '' )
call s:HI(          'Debug', 'NONE', s:dred,             '' )
call s:HI(     'MatchParen', s:dwht, s:dblk,             '' )
call s:HI(       'ErrorMsg', 'NONE', s:color250,         '' )
call s:HI(       'WildMenu', s:dblk, s:dmag,             '' )
call s:HI(         'Folded', s:color32, s:dwht,          '' )
call s:HI(         'Search', s:dblu, s:dblk, '' )
call s:HI(      'IncSearch', s:dblk, s:colorsearch, 'underline' )
call s:HI(     'WarningMsg', 'NONE', s:color250, '' )
call s:HI(       'Question', 'NONE', s:lgrn,     '' )
call s:HI(         'Visual', s:color62, s:dwht,  '' )
call s:HI(     'StatusLine', 'NONE', s:dblu,     'bold' )
call s:HI(   'StatusLineNC', 'NONE', 'NONE',     'none' )
call s:HI(      'VertSplit', 'NONE', 'NONE',     'none' )
call s:HI(        'TabLine', s:dblk, s:dwht,     '' )
call s:HI(    'TabLineFill', 'NONE', s:dblk,     '' )
call s:HI(     'TabLineSel', s:dblk, s:dwht,     '' )
call s:HI(         'Cursor', s:colorcursor, 'NONE', 'NONE' )
call s:HI(     'CursorLine', s:color234, 'NONE', 'none' )
call s:HI(   'CursorLineNr', 'NONE', s:lylw,     'none' )
call s:HI(   'CursorColumn', s:culc, 'NONE',     '' )
call s:HI(    'ColorColumn', s:culc, 'NONE',     '' )
call s:HI(     'FoldColumn', 'NONE', s:lblk,     '' )
call s:HI(     'SignColumn', 'NONE', 'NONE',     '' )
call s:HI(        'DiffAdd', s:lwht, s:color225, '' )
call s:HI(     'DiffChange', s:lwht, s:color228, '' )
call s:HI(       'DiffText', 'NONE', s:lwht, '' )
call s:HI(     'DiffDelete', s:color162, s:color127, '' )
call s:HI(          'Error', s:color162, s:color127, '' )

call s:HI(          'Pmenu', s:color253, s:color234, 'reverse' )
call s:HI(       'PmenuSel', s:colorsearch, s:color200, 'reverse' )
call s:HI(      'PmenuSbar', s:dblk, 'NONE', '' )
call s:HI(     'PmenuThumb', s:dgrn, 'NONE', '' )

call s:HI( 'vimCommentTitle',     '', s:lgrn, '' )
call s:HI(         'vimFold', s:lwht, s:dblk, '' )

call s:HI( 'helpHyperTextJump', '', s:lylw, '' )

call s:HI( 'javaScriptNumber', '', s:lylw, '' )

call s:HI(     'htmlTag', '', s:dcyn, '' )
call s:HI(  'htmlEndTag', '', s:dcyn, '' )
call s:HI( 'htmlTagName', '', s:lylw, '' )

call s:HI(        'perlSharpBang', '', s:lgrn, 'standout' )
call s:HI(        'perlStatement', '', s:lmag,         '' )
call s:HI( 'perlStatementStorage', '', s:dred,         '' )
call s:HI(         'perlVarPlain', '', s:dylw,         '' )
call s:HI(        'perlVarPlain2', '', s:lylw,         '' )

call s:HI( 'rubySharpBang', '', s:lgrn, 'standout' )

call s:HI(    'diffLine', '', s:lgrn, '' )
call s:HI( 'diffOldLine', '', s:dgrn, '' )
call s:HI( 'diffOldFile', '', s:dgrn, '' )
call s:HI( 'diffNewFile', '', s:dgrn, '' )
call s:HI(   'diffAdded', '', s:dblu, '' )
call s:HI( 'diffRemoved', '', s:dred, '' )
call s:HI( 'diffChanged', '', s:dcyn, '' )
call s:HI( 'fzf1', '', s:dred, '' )
call s:HI( 'fzf2', '', s:dylw, '' )
call s:HI( 'fzf3', '', s:lylw, '' )

if has('spell')
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellRare
    hi clear SpellLocal
    call s:HI(   'SpellBad', '', '', 'underline' )
    call s:HI(   'SpellCap', '', '', 'underline' )
    call s:HI(  'SpellRare', '', '', 'underline' )
    call s:HI( 'SpellLocal', '', '', 'underline' )
endif

call s:HI(   'SyntasticErrorSign', s:culc, s:lred, '' )
call s:HI( 'SyntasticWarningSign', s:culc, s:lmag, '' )

call s:HI(   'TermCursor', s:colorcursor, 'NONE', 'NONE' )
call s:HI( 'TermCursorNC', s:lblk, 'NONE', 'NONE' )

if (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR)
    let g:terminal_color_0=s:dblk
    let g:terminal_color_8=s:lblk
    let g:terminal_color_1=s:dred
    let g:terminal_color_9=s:lred
    let g:terminal_color_2=s:dgrn
    let g:terminal_color_10=s:lgrn
    let g:terminal_color_3=s:dylw
    let g:terminal_color_11=s:lylw
    let g:terminal_color_4=s:dblu
    let g:terminal_color_12=s:lblu
    let g:terminal_color_5=s:dmag
    let g:terminal_color_13=s:lmag
    let g:terminal_color_6=s:dcyn
    let g:terminal_color_14=s:lcyn
    let g:terminal_color_7=s:dwht
    let g:terminal_color_15=s:lwht
endif

if has('spell')
    hi! clear SpellBad
    hi! clear SpellCap
    hi! clear SpellRare
    hi! clear SpellLocal
endif

syn region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}\|%stopzone\>' contains=@Spell
syn region texZone start='\\begin{minted}' end='\\end{minted}\|%stopzone\>' contains=@Spell

if exists( 'g:loaded_operator_highlight' )
  finish
else
  let g:loaded_operator_highlight = 1
endif

if !exists( 'g:ophigh_filetypes_to_ignore' )
  let g:ophigh_filetypes_to_ignore = {}
endif

fun! s:IgnoreFiletypeIfNotSet( file_type )
  if get( g:ophigh_filetypes_to_ignore, a:file_type, 1 )
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
