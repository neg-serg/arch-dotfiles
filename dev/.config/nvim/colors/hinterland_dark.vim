" Name: hinterland dark
" Author: Protesilaos Stavrou <public@protesilaos.com>
" URL: https://protesilaos.com/hinterland

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "hinterland_dark"

" General
" -----------------
hi Normal guibg=#12171B guifg=#8aa0a4 ctermbg=none ctermfg=14
hi Visual guibg=#e9e8ec guifg=#3d463f ctermbg=7 ctermfg=10
hi Search guibg=#01917b guifg=#f9f8fc ctermbg=6 ctermfg=15

hi StatusLine gui=none,bold guibg=#22272B guifg=#8aa0a4 cterm=none,bold ctermbg=8 ctermfg=14
hi StatusLineNC gui=none guibg=#22272B guifg=#3d463f cterm=none ctermbg=8 ctermfg=10
hi VertSplit gui=none cterm=none
hi TabLine gui=none guibg=#22272B guifg=#60604f cterm=none ctermbg=8 ctermfg=11
hi TabLineSel gui=none guibg=#217ab3 guifg=#f9f8fc cterm=none ctermbg=4 ctermfg=15
hi TabLineFill gui=none cterm=none

hi Comment gui=italic guifg=#60604f cterm=italic ctermfg=11
hi Todo gui=none guibg=#22272B guifg=#ad5c5b cterm=none ctermbg=8 ctermfg=5

hi Warning gui=none guibg=#b09020 guifg=#f9f8fc cterm=none ctermbg=3 ctermfg=15
hi Error gui=none guibg=#983f16 guifg=#f9f8fc cterm=none ctermbg=1 ctermfg=15

hi MatchParen guibg=#01917b guifg=#f9f8fc ctermbg=6 ctermfg=15

" Constructs
" -----------------
hi Constant guifg=#3D814C ctermfg=2
hi Number guifg=#9e6c3d ctermfg=9
hi Boolean guifg=#ad5c5b ctermfg=5
hi Float guifg=#9e6c3d ctermfg=9
hi Label guifg=#01917b ctermfg=6
hi Tag guifg=#8aa0a4 ctermfg=14
hi StorageClass guifg=#8aa0a4 ctermfg=14

hi String guifg=#7d6cab ctermfg=13
hi Character guifg=#b09020 ctermfg=3

hi Identifier gui=none guifg=#01917b cterm=none ctermfg=6
hi Function guifg=#01917b ctermfg=6
hi Keyword guifg=#01917b ctermfg=6
hi Statement guifg=#3D814C ctermfg=2
hi Conditional guifg=#01917b ctermfg=6
hi Repeat guifg=#217ab3 ctermfg=4
hi Operator guifg=#b09020 ctermfg=3
hi Keyword guifg=#01917b ctermfg=6
hi Exception guifg=#983f16 ctermfg=1

hi Preproc guifg=#3D814C ctermfg=2
hi Include guifg=#01917b ctermfg=6
hi Define guifg=#9e6c3d ctermfg=9
hi Macro guifg=#9e6c3d ctermfg=9
hi PreCondit guifg=#01917b ctermfg=6

hi Title guifg=#8aa0a4 ctermfg=14
hi Type guifg=#01917b ctermfg=6
hi StorageClass guifg=#01917b ctermfg=6
hi Structure guifg=#3D814C ctermfg=2
hi Typedef guifg=#9e6c3d ctermfg=9

hi Special guifg=#b09020 ctermfg=3
hi SpecialChar guifg=#ad5c5b ctermfg=5
hi Tag guifg=#01917b ctermfg=6
hi Delimeter guifg=#8aa0a4 ctermfg=14
hi SpecialComment gui=none guifg=#217ab3 cterm=none ctermfg=4
hi Debug guifg=#983f16

" Other
" -----------------
hi LineNr guifg=#60604f ctermfg=11
hi Cursor guifg=#8aa0a4 ctermfg=14
hi CursorLine gui=none guibg=#22272B cterm=none ctermbg=8
hi CursorLineNr gui=none guibg=#22272B guifg=#768592 cterm=none ctermbg=8 ctermfg=12
hi ColorColumn guibg=#60604f ctermbg=11

hi Folded guibg=#22272B guifg=#f9f8fc ctermbg=8 ctermfg=15
hi FoldColumn guibg=#22272B guifg=#f9f8fc ctermbg=8 ctermfg=15
hi SignColumn guibg=#22272B guifg=#f9f8fc ctermbg=8 ctermfg=15

hi NonText guifg=#60604f ctermfg=11
hi SpecialKey guifg=#60604f ctermfg=11

hi Directory guifg=#3D814C ctermfg=2
hi SpecialKey guifg=#ad5c5b ctermfg=5
hi MoreMsg guifg=#60604f ctermfg=11
hi Question gui=none guifg=#983f16 cterm=none ctermfg=1
hi VimOption guifg=#9e6c3d ctermfg=9
hi VimGroup guifg=#3D814C ctermfg=2
hi Underlined guifg=#7d6cab ctermfg=13
hi Ignore guifg=#217ab3 ctermfg=5

hi SpellBad guibg=#983f16 guifg=#f9f8fc ctermbg=1 ctermfg=15
hi SpellCap guibg=#22272B guifg=#f9f8fc ctermbg=8 ctermfg=15
hi SpellRare guibg=#7d6cab guifg=#f9f8fc ctermbg=13 ctermfg=15
hi SpellLocal guibg=#01917b guifg=#f9f8fc ctermbg=6 ctermfg=15

hi Pmenu guibg=#22272B guifg=#f9f8fc ctermbg=8 ctermfg=15
hi PmenuSel guibg=#b09020 guifg=#f9f8fc ctermbg=3 ctermfg=15
hi PmenuSbar guibg=#60604f ctermbg=11

" Diffs
" -----------------
hi DiffAdd guibg=#3D814C guifg=#f9f8fc ctermbg=2 ctermfg=15
hi DiffDelete gui=none guibg=#983f16 guifg=#f9f8fc ctermbg=1 cterm=none ctermfg=15
hi DiffChange guibg=#9e6c3d guifg=#f9f8fc ctermbg=9 ctermfg=15
hi DiffText gui=none guibg=#ad5c5b guifg=#f9f8fc cterm=none ctermbg=5 ctermfg=15

hi diffAdded guifg=#3D814C ctermfg=2
hi diffRemoved guifg=#983f16 ctermfg=1
hi diffNewFile gui=none guifg=#217ab3 ctermfg=4
hi diffFile gui=none guifg=#b09020 cterm=none ctermfg=3
