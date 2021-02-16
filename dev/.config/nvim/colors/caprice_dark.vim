" Name: caprice dark
" Author: Protesilaos Stavrou <public@protesilaos.com>
" URL: https://protesilaos.com/caprice

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "caprice_dark"

" General
" -----------------
hi Normal guibg=#211b29 guifg=#a19ba9 ctermbg=none ctermfg=14
hi Visual guibg=#eeebec guifg=#2e2b2c ctermbg=7 ctermfg=10
hi Search guibg=#587ebc guifg=#fefbfc ctermbg=6 ctermfg=15

hi StatusLine gui=none,bold guibg=#312b39 guifg=#a19ba9 cterm=none,bold ctermbg=8 ctermfg=14
hi StatusLineNC gui=none guibg=#312b39 guifg=#2e2b2c cterm=none ctermbg=8 ctermfg=10
hi VertSplit gui=none cterm=none
hi TabLine gui=none guibg=#312b39 guifg=#716b79 cterm=none ctermbg=8 ctermfg=11
hi TabLineSel gui=none guibg=#585ebc guifg=#fefbfc cterm=none ctermbg=4 ctermfg=15
hi TabLineFill gui=none cterm=none

hi Comment gui=italic guifg=#716b79 cterm=italic ctermfg=11
hi Todo gui=none guibg=#312b39 guifg=#983d4f cterm=none ctermbg=8 ctermfg=1

hi Warning gui=none guibg=#a58a30 guifg=#fefbfc cterm=none ctermbg=3 ctermfg=15
hi Error gui=none guibg=#983d4f guifg=#fefbfc cterm=none ctermbg=1 ctermfg=15

hi MatchParen guibg=#587ebc guifg=#fefbfc ctermbg=6 ctermfg=15

" Constructs
" -----------------
hi Constant guifg=#8955a2 ctermfg=13
hi Number guifg=#585ebc ctermfg=4
hi Boolean guifg=#983d4f ctermfg=1
hi Float guifg=#585ebc ctermfg=4
hi Label guifg=#278975 ctermfg=2
hi Tag guifg=#a19ba9 ctermfg=14
hi StorageClass guifg=#a19ba9 ctermfg=14

hi String guifg=#587ebc ctermfg=6
hi Character guifg=#ac4d7a ctermfg=5

hi Identifier gui=none guifg=#278975 cterm=none ctermfg=2
hi Function guifg=#278975 ctermfg=2
hi Keyword guifg=#278975 ctermfg=2
hi Statement guifg=#8955a2 ctermfg=13
hi Conditional guifg=#278975 ctermfg=2
hi Repeat guifg=#9a5d38 ctermfg=9
hi Operator guifg=#ac4d7a ctermfg=5
hi Keyword guifg=#278975 ctermfg=2
hi Exception guifg=#a58a30 ctermfg=3

hi Preproc guifg=#8955a2 ctermfg=13
hi Include guifg=#278975 ctermfg=2
hi Define guifg=#585ebc ctermfg=4
hi Macro guifg=#585ebc ctermfg=4
hi PreCondit guifg=#278975 ctermfg=2

hi Title guifg=#a19ba9 ctermfg=14
hi Type guifg=#278975 ctermfg=2
hi StorageClass guifg=#278975 ctermfg=2
hi Structure guifg=#8955a2 ctermfg=13
hi Typedef guifg=#585ebc ctermfg=4

hi Special guifg=#ac4d7a ctermfg=5
hi SpecialChar guifg=#983d4f ctermfg=1
hi Tag guifg=#278975 ctermfg=2
hi Delimeter guifg=#a19ba9 ctermfg=14
hi SpecialComment gui=none guifg=#9a5d38 cterm=none ctermfg=9
hi Debug guifg=#a58a30

" Other
" -----------------
hi LineNr guifg=#716b79 ctermfg=11
hi Cursor guifg=#a19ba9 ctermfg=14
hi CursorLine gui=none guibg=#312b39 cterm=none ctermbg=8
hi CursorLineNr gui=none guibg=#312b39 guifg=#7e7b7c cterm=none ctermbg=8 ctermfg=12
hi ColorColumn guibg=#716b79 ctermbg=11

hi Folded guibg=#312b39 guifg=#fefbfc ctermbg=8 ctermfg=15
hi FoldColumn guibg=#312b39 guifg=#fefbfc ctermbg=8 ctermfg=15
hi SignColumn guibg=#312b39 guifg=#fefbfc ctermbg=8 ctermfg=15

hi NonText guifg=#716b79 ctermfg=11
hi SpecialKey guifg=#716b79 ctermfg=11

hi Directory guifg=#8955a2 ctermfg=13
hi SpecialKey guifg=#983d4f ctermfg=1
hi MoreMsg guifg=#716b79 ctermfg=11
hi Question gui=none guifg=#a58a30 cterm=none ctermfg=3
hi VimOption guifg=#585ebc ctermfg=4
hi VimGroup guifg=#8955a2 ctermfg=13
hi Underlined guifg=#587ebc ctermfg=6
hi Ignore guifg=#9a5d38 ctermfg=1

hi SpellBad guibg=#983d4f guifg=#fefbfc ctermbg=1 ctermfg=15
hi SpellCap guibg=#312b39 guifg=#fefbfc ctermbg=8 ctermfg=15
hi SpellRare guibg=#8955a2 guifg=#fefbfc ctermbg=13 ctermfg=15
hi SpellLocal guibg=#587ebc guifg=#fefbfc ctermbg=6 ctermfg=15

hi Pmenu guibg=#312b39 guifg=#fefbfc ctermbg=8 ctermfg=15
hi PmenuSel guibg=#a58a30 guifg=#fefbfc ctermbg=3 ctermfg=15
hi PmenuSbar guibg=#716b79 ctermbg=11

" Diffs
" -----------------
hi DiffAdd guibg=#278975 guifg=#fefbfc ctermbg=2 ctermfg=15
hi DiffDelete gui=none guibg=#983d4f guifg=#fefbfc ctermbg=1 cterm=none ctermfg=15
hi DiffChange guibg=#9a5d38 guifg=#fefbfc ctermbg=9 ctermfg=15
hi DiffText gui=none guibg=#ac4d7a guifg=#fefbfc cterm=none ctermbg=5 ctermfg=15

hi diffAdded guifg=#278975 ctermfg=2
hi diffRemoved guifg=#983d4f ctermfg=1
hi diffNewFile gui=none guifg=#585ebc ctermfg=4
hi diffFile gui=none guifg=#a58a30 cterm=none ctermfg=3
