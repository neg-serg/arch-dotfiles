" Name: seabed dark
" Author: Protesilaos Stavrou <public@protesilaos.com>
" URL: https://protesilaos.com/seabed

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "seabed_dark"

" General
" -----------------
hi Normal guibg=#060d18 guifg=#969da8 ctermbg=none ctermfg=14
hi Visual guibg=#263d48 guifg=#96adb8 ctermbg=7 ctermfg=10
hi Search guibg=#35838c guifg=#162d38 ctermbg=6 ctermfg=15

hi StatusLine gui=none,bold guibg=#161d28 guifg=#969da8 cterm=none,bold ctermbg=8 ctermfg=14
hi StatusLineNC gui=none guibg=#161d28 guifg=#96adb8 cterm=none ctermbg=8 ctermfg=10
hi VertSplit gui=none cterm=none
hi TabLine gui=none guibg=#161d28 guifg=#666d78 cterm=none ctermbg=8 ctermfg=11
hi TabLineSel gui=none guibg=#3a6a8d guifg=#162d38 cterm=none ctermbg=4 ctermfg=15
hi TabLineFill gui=none cterm=none

hi Comment gui=italic guifg=#666d78 cterm=italic ctermfg=11
hi Todo gui=none guibg=#161d28 guifg=#6a865a cterm=none ctermbg=8 ctermfg=3

hi Warning gui=none guibg=#6a865a guifg=#162d38 cterm=none ctermbg=3 ctermfg=15
hi Error gui=none guibg=#78456b guifg=#162d38 cterm=none ctermbg=1 ctermfg=15

hi MatchParen guibg=#35838c guifg=#162d38 ctermbg=6 ctermfg=15

" Constructs
" -----------------
hi Constant guifg=#3a6a8d ctermfg=4
hi Number guifg=#846b85 ctermfg=5
hi Boolean guifg=#6a865a ctermfg=3
hi Float guifg=#846b85 ctermfg=5
hi Label guifg=#4d5b94 ctermfg=13
hi Tag guifg=#969da8 ctermfg=14
hi StorageClass guifg=#969da8 ctermfg=14

hi String guifg=#2d886c ctermfg=2
hi Character guifg=#35838c ctermfg=6

hi Identifier gui=none guifg=#4d5b94 cterm=none ctermfg=13
hi Function guifg=#4d5b94 ctermfg=13
hi Keyword guifg=#4d5b94 ctermfg=13
hi Statement guifg=#3a6a8d ctermfg=4
hi Conditional guifg=#4d5b94 ctermfg=13
hi Repeat guifg=#78456b ctermfg=1
hi Operator guifg=#35838c ctermfg=6
hi Keyword guifg=#4d5b94 ctermfg=13
hi Exception guifg=#6a867a ctermfg=9

hi Preproc guifg=#3a6a8d ctermfg=4
hi Include guifg=#4d5b94 ctermfg=13
hi Define guifg=#846b85 ctermfg=5
hi Macro guifg=#846b85 ctermfg=5
hi PreCondit guifg=#4d5b94 ctermfg=13

hi Title guifg=#969da8 ctermfg=14
hi Type guifg=#4d5b94 ctermfg=13
hi StorageClass guifg=#4d5b94 ctermfg=13
hi Structure guifg=#3a6a8d ctermfg=4
hi Typedef guifg=#846b85 ctermfg=5

hi Special guifg=#35838c ctermfg=6
hi SpecialChar guifg=#6a865a ctermfg=3
hi Tag guifg=#4d5b94 ctermfg=13
hi Delimeter guifg=#969da8 ctermfg=14
hi SpecialComment gui=none guifg=#78456b cterm=none ctermfg=1
hi Debug guifg=#6a867a

" Other
" -----------------
hi LineNr guifg=#666d78 ctermfg=11
hi Cursor guifg=#969da8 ctermfg=14
hi CursorLine gui=none guibg=#161d28 cterm=none ctermbg=8
hi CursorLineNr gui=none guibg=#161d28 guifg=#667d88 cterm=none ctermbg=8 ctermfg=12
hi ColorColumn guibg=#666d78 ctermbg=11

hi Folded guibg=#161d28 guifg=#162d38 ctermbg=8 ctermfg=15
hi FoldColumn guibg=#161d28 guifg=#162d38 ctermbg=8 ctermfg=15
hi SignColumn guibg=#161d28 guifg=#162d38 ctermbg=8 ctermfg=15

hi NonText guifg=#666d78 ctermfg=11
hi SpecialKey guifg=#666d78 ctermfg=11

hi Directory guifg=#3a6a8d ctermfg=4
hi SpecialKey guifg=#6a865a ctermfg=3
hi MoreMsg guifg=#666d78 ctermfg=11
hi Question gui=none guifg=#6a867a cterm=none ctermfg=9
hi VimOption guifg=#846b85 ctermfg=5
hi VimGroup guifg=#3a6a8d ctermfg=4
hi Underlined guifg=#2d886c ctermfg=2
hi Ignore guifg=#78456b ctermfg=3

hi SpellBad guibg=#78456b guifg=#162d38 ctermbg=1 ctermfg=15
hi SpellCap guibg=#161d28 guifg=#162d38 ctermbg=8 ctermfg=15
hi SpellRare guibg=#4d5b94 guifg=#162d38 ctermbg=13 ctermfg=15
hi SpellLocal guibg=#35838c guifg=#162d38 ctermbg=6 ctermfg=15

hi Pmenu guibg=#161d28 guifg=#162d38 ctermbg=8 ctermfg=15
hi PmenuSel guibg=#6a865a guifg=#162d38 ctermbg=3 ctermfg=15
hi PmenuSbar guibg=#666d78 ctermbg=11

" Diffs
" -----------------
hi DiffAdd guibg=#2d886c guifg=#162d38 ctermbg=2 ctermfg=15
hi DiffDelete gui=none guibg=#78456b guifg=#162d38 ctermbg=1 cterm=none ctermfg=15
hi DiffChange guibg=#6a867a guifg=#162d38 ctermbg=9 ctermfg=15
hi DiffText gui=none guibg=#846b85 guifg=#162d38 cterm=none ctermbg=5 ctermfg=15

hi diffAdded guifg=#2d886c ctermfg=2
hi diffRemoved guifg=#78456b ctermfg=1
hi diffNewFile gui=none guifg=#3a6a8d ctermfg=4
hi diffFile gui=none guifg=#6a865a cterm=none ctermfg=3
