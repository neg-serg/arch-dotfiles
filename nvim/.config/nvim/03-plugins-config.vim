" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - neoclide/coc.nvim                                                        │
" │ https://github.com/neoclide/coc.nvim                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_status_warning_sign = ""
let g:coc_status_error_sign = ""

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [Qleader]c <Plug>(coc-diagnostic-next)
nmap <silent> [Qleader]C <Plug>(coc-diagnostic-prev)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Try autofix current
nmap <leader>qf  <Plug>(coc-fix-current)
" Reformat command
command! -nargs=0 Format :call CocAction('format')
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-session                                                        │ 
" │ https://github.com/xolox/vim-session                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:session_lock_enabled = 0
let g:session_verbose_messages = 0
let g:session_autosave_silent = 1
let g:session_default_to_last = 1
let g:session_autosave_to = 'default'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - airblade/vim-gitgutter                                                   │ 
" │ https://github.com/airblade/vim-gitgutter                                         │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:gitgutter_realtime = 1
let g:gitgutter_async = 1
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
highlight SignColumn ctermbg=4
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - w0rp/ale                                                                 │ 
" │ https://github.com/w0rp/ale                                                       │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:ale_sign_warning = '⚡'
let g:ale_sign_error = '✖'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - junegunn/fzf.vim                                                         │ 
" │ https://github.com/junegunn/fzf.vim                                               │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if executable('rg')
    let s:rg_cmd = "rg --hidden --follow"
    let s:rg_ignore = split(&wildignore, ',') + [
        \ 'node_modules', 'target', 'build', 'dist', '.stack-work'
        \ ]
    let s:rg_cmd .= " --glob '!{'" . shellescape(join(s:rg_ignore, ',')) . "'}'"
    let &grepprg=s:rg_cmd . ' --vimgrep'
    let $FZF_DEFAULT_COMMAND = 'rg --files'
endif

nnoremap qe :Files %:p:h<CR>
nnoremap qE :Files<CR>
nnoremap ed :Buffers<CR>

" This is the default extra key bindings
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
    \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

" Insert mode completion
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)
autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> setlocal laststatus=2 showmode ruler
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - pbogut/fzf-mru.vim                                                       │
" │ https://github.com/pbogut/fzf-mru.vim                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <Leader>. :FZFMru --prompt "❯> "<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:LustyJugglerDefaultMappings = 0
let LustyExplorerDefaultMappings  = 0
nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - derekwyatt/vim-fswitch.git                                               │
" │ https://github.com/derekwyatt/vim-fswitch.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
" A "companion" file is a .cpp file to an .h file and vice versa
" Opens the companion file in the current window
nnoremap [FLeader]fs :FSHere<cr>
" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap [FLeader]sl :call FSwitch('%', 'wincmd l')<cr>
" Same as above, only opens it in window to the right
nnoremap [FLeader]sr :call FSwitch('%', 'wincmd r')<cr>
" Creates a new window on the left and opens the companion file in it
nnoremap [FLeader]sv :FSSplitLeft<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - gregsexton/gitv.git                                                      │
" │ https://github.com/gregsexton/gitv.git                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:Gitv_OpenHorizontal      = 'auto'
let g:Gitv_OpenPreviewOnLaunch = 1
let g:Gitv_WipeAllOnClose      = 1
let g:Gitv_DoNotMapCtrlKey     = 1
let g:Gitv_CommitStep          = 1024
nnoremap <silent> <leader>gv :Gitv --all<CR>
nnoremap <silent> <leader>gV :Gitv! --all<CR>
vnoremap <silent> <leader>gV :Gitv! --all<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Valloric/ListToggle.git                                                  │
" │ https://github.com/Valloric/ListToggle.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:lt_height = 10
let g:lt_location_list_toggle_map = '[Qleader]S-q'
let g:lt_quickfix_list_toggle_map = '[Qleader]q'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Raimondi/delimitMate.git                                                 │
" │ https://github.com/Raimondi/delimitMate.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:delimitMate_expand_space       = 1
let g:delimitMate_expand_cr          = 0
let g:delimitMate_smart_quotes       = 1
let g:delimitMate_balance_matchpairs = 1
imap <Esc>OH <Plug>delimitMateHome
imap <Esc>OF <Plug>delimitMateEnd
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - dbakker/vim-projectroot.git                                              │
" │ https://github.com/dbakker/vim-projectroot.git                                    │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> cd :ProjectRootCD<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bbchung/gasynctags.git                                                   │
" │ https://github.com/bbchung/gasynctags.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:gasynctags_autostart = 0
nmap <silent><space>d :GasyncTagsEnable<CR>:GtagsCscope<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-dispatch.git                                                   │
" │ https://github.com/tpope/vim-dispatch.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap MK :Make -j9
nmap MC :Make clean<cr>
nmap [FLeader]cc :Make -j10<cr>
nmap [FLeader]mc :Make distclean<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - frazrepo/vim-rainbow                                                     │
" │ https://github.com/frazrepo/vim-rainbow                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf_defaults = {
\	'ctermfgs': ['lightblue'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'contains_prefix': 'TOP',
\	'parentheses_options': '',
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\		},
\		'ocaml': {
\			'parentheses': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
\		},
\		'tex': {
\			'parentheses_options': 'containedin=texDocZone',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody,vimExecute',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\		},
\		'xml': {
\			'syn_name_prefix': 'xmlRainbow',
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'xhtml': {
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow',
\		},
\		'php': {
\			'syn_name_prefix': 'phpBlockRainbow',
\			'contains_prefix': '',
\			'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0,
\		'sh': 0,
\	}
\ }
let s:rainbow_darkblue_colors = ["#2A4769", "#264263", "#223E5E"]
let s:rainbow_royalblue_colors = ['#4169E1', '#3D63D4', '#3B5FCC', '#385AC2', '#3454B5']
let g:rainbow_conf_defaults['guifgs'] = s:rainbow_royalblue_colors
let g:rainbow_conf = g:rainbow_conf_defaults
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-markdown                                                       │
" │ https://github.com/tpope/vim-markdown                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:markdown_minlines                           = 100
let g:markdown_syntax_conceal                     = 0
let g:markdown_enable_mappings                    = 0
let g:markdown_enable_insert_mode_leader_mappings = 0
let g:markdown_enable_spell_checking              = 0
let g:markdown_quote_syntax_filetypes = {
    \ "vim" : {
    \   "start" : "\\%(vim\\|viml\\)",
    \},
    \}
if executable('firefox')
    let g:mkdp_path_to_chrome= get(g:, 'mkdp_path_to_chrome', 'firefox')
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - mhinz/vim-grepper                                                        │
" │ https://github.com/mhinz/vim-grepper                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <A-/> :Grepper -tool rg<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - gregsexton/gitv                                                          │
" │ https://github.com/gregsexton/gitv                                                │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:Gitv_OpenHorizontal = 0
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - FooSoft/vim-argwrap                                                      │
" │ https://github.com/FooSoft/vim-argwrap                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>a :ArgWrap<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - jiangmiao/auto-pairs                                                     │
" │ https://github.com/jiangmiao/auto-pairs                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:AutoPairs =  {'(':')', '[':']', '{':'}', '<':'>'}
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - airblade/vim-rooter                                                      │
" │ https://github.com/airblade/vim-rooter                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rooter_targets = '/,*' " directories and all files (default)
let g:rooter_use_lcd = 1 " change directory for the current window only
" change dir to current if there is no project
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - liuchengxu/vim-clap                                                      │
" │ https://github.com/liuchengxu/vim-clap                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:clap_theme = 'material_design_dark'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - easymotion/vim-easymotion                                                │
" │ https://github.com/easymotion/vim-easymotion                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap gs <Plug>(easymotion-overwin-f2)
" map <NOP> <Plug>(easymotion-prefix)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - junegunn/vim-easy-align                                                  │
" │ https://github.com/junegunn/vim-easy-align                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
