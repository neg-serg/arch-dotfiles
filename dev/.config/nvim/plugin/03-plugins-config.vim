" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ pbogut/fzf-mru.vim                                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>. :FZFMru --prompt "❯> "<CR>
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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ FooSoft/vim-argwrap                                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>a :ArgWrap<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ pearofducks/ansible-vim                                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
augroup ansible_vim_fthosts
  autocmd!
  autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
  autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
augroup END
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ eugen0329/vim-esearch                                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap <C-f>f <Plug>(esearch)
map <C-f> <Plug>(esearch-prefill)
let g:esearch = {}
" Use regex matching with the smart case mode by default and avoid matching text-objects.
let g:esearch.default_mappings = 0
let g:esearch.regex = 'auto'
let g:esearch.textobj = 0
let g:esearch.adapter = 'rg'
let g:esearch.case = 'smart'
let g:esearch.win_contexts_syntax = 0
" Set the initial pattern content using the highlighted search pattern (if
" v:hlsearch is true), the last searched pattern or the clipboard content.
let g:esearch.prefill = ['hlsearch', 'clipboard']
" Open the search window in a vertical split and reuse it for all searches.
let g:esearch.win_new = {-> esearch#buf#goto_or_open('[Search]', 'vnew') }
" Redefine the default highlights (see :help highlight and :help esearch-appearance)
hi esearchHeader gui=bold
hi link esearchStatistics esearchFilename
hi link esearchFilename Label
hi esearchMatch gui=underline,italic,bold guifg=#6C7E96 guibg=#002D59
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ ojroques/vim-oscyank                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
