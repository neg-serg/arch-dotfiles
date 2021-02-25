" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ frazrepo/vim-rainbow                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf_defaults = {
\	'guis': [''],
\	'separately': {
\		'*': {},
\		'markdown': { 'parentheses_options': 'containedin=markdownCode contained', },
\		'lisp': { 'guifgs': ['#365e96', '#315587', '#2e5080', '#294873', '#26436b'], },
\		'css': 0, 'sh': 0, } }
let s:rainbow_darkblue_colors = ['#2A4769', '#264263', '#223E5E']
let s:rainbow_royalblue_colors = ['#4169E1', '#3D63D4', '#3B5FCC', '#385AC2', '#3454B5']
let s:rainbow_darkblue_colors2 = ['#365e96', '#315587', '#2e5080', '#294873', '#26436b']
let g:rainbow_conf_defaults['guifgs'] = s:rainbow_darkblue_colors2
let g:rainbow_conf = g:rainbow_conf_defaults
