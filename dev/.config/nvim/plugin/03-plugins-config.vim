" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ neoclide/coc.nvim                                                            │
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
let g:coc_status_warning_sign = ''
let g:coc_status_error_sign = ''
let g:coc_snippet_next = '<tab>'
" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [Qleader]c <Plug>(coc-diagnostic-next)
nmap <silent> [Qleader]C <Plug>(coc-diagnostic-prev)
nmap <silent> <M-CR> <Plug>(coc-fix-current)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>
nmap <silent> gr :<C-u>CocCommand fzf-preview.CocReferences<CR>
" Remap for rename current word
nmap <silent> [Qleader]r <Plug>(coc-rename)
" Reformat command
command! -nargs=0 Format :call CocAction('format')
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ w0rp/ale                                                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'json': ['jq'],
    \ 'html': ['prettier'],
    \ 'scss': ['stylelint'],
    \ 'less': ['stylelint'],
    \ 'css': ['stylelint'],
    \ 'python': ['black', 'yapf'],
    \ 'rust': ['rustfmt']
\ }
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_highlight_linenrs = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ junegunn/fzf.vim                                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    let s:rg_cmd = 'rg --hidden --follow'
    let &grepprg=s:rg_cmd . ' --vimgrep'
    let s:rg_ignore = split(&wildignore, ',') + [
        \ 'node_modules', 'target', 'build', 'dist', '.stack-work'
        \ ]
    let s:rg_cmd .= " --glob '!{'" . shellescape(join(s:rg_ignore, ',')) . "'}'"
endif
nnoremap <silent> [Qleader]E :Files %:p:h<CR>
nnoremap <silent> [Qleader]e :Files<CR>
" This is the default extra key bindings
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
augroup fzf
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> setlocal laststatus=2 showmode
    " Advanced customization using autoload functions
    autocmd VimEnter * command! Colors
        \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})
augroup end

" Insert mode completion
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-l> <Plug>(fzf-complete-line)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ pbogut/fzf-mru.vim                                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>. :FZFMru --prompt "❯> "<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │  █▓▒░ sjbach/lusty.git                                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:LustyJugglerDefaultMappings = 0
let LustyExplorerDefaultMappings = 0
let g:LustyExplorerAlwaysShowDotFiles = 1
nmap <silent> <leader>l :packadd lusty<CR>:LustyFilesystemExplorerFromHere<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ tpope/vim-dispatch.git                                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap MK :Make -j9
nmap MC :Make clean<cr>
nmap [QLeader]cc :Make -j10<cr>
nmap [QLeader]mc :Make distclean<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ frazrepo/vim-rainbow                                                         │
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
" │ █▓▒░ jiangmiao/auto-pairs                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:AutoPairs =  {'(':')', '[':']', '{':'}', '<':'>'}
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ airblade/vim-rooter                                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rooter_targets = '/,*' " directories and all files (default)
let g:rooter_cd_cmd='lcd' " change directory for the current window only
" change dir to current if there is no project
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ junegunn/vim-easy-align                                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ vimwiki/vimwiki                                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:vimwiki_ext2syntax = {'.md': 'markdown',
    \ '.mkd': 'markdown',
    \ '.wiki': 'media'}
let g:vimwiki_list = [{'path': '~/1st_level/'}]
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ liuchengxu/vista.vim                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:vista_sidebar_width = 20
let g:vista_disable_statusline = 1
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ['▸ ', '']
let     g:vista#renderer#icons = {
      \ 'augroup':        "פּ",
      \ 'class':          "",
      \ 'constant':       '',
      \ 'default':        "",
      \ 'enum':           "",
      \ 'enumerator':     "",
      \ 'field':          "",
      \ 'fields':         "",
      \ 'functions':      "ﬦ",
      \ 'function':       "ﬦ",
      \ 'func':           "ﬦ",
      \ 'implementation': "",
      \ 'interface':      "",
      \ 'macro':          "",
      \ 'macros':         "",
      \ 'map':            "פּ",
      \ 'member':         "",
      \ 'method':         "",
      \ 'module':         '',
      \ 'modules':        "",
      \ 'namespace':      "",
      \ 'package':        "",
      \ 'packages':       "",
      \ 'property':       "襁",
      \ 'struct':         "",
      \ 'subroutine':     "羚",
      \ 'target':         "",
      \ 'type':           "",
      \ 'typedef':        "",
      \ 'typeParameter':  "",
      \ 'types':          "",
      \ 'union':          "鬒",
      \ 'variables':      "\ufb18",
      \ 'variable':       "\ufb18",
      \ 'var':            "\ufb18"
\ }
let g:vista_default_executive = 'coc'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ rhysd/git-messenger.vim                                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap <C-f> <Plug>(git-messenger)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ haya14busa/vim-asterisk                                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
map *   <Plug>(asterisk-#)
map #   <Plug>(asterisk-*)
map g*  <Plug>(asterisk-g#)
map g#  <Plug>(asterisk-g*)
map z*  <Plug>(asterisk-z#)
map gz* <Plug>(asterisk-gz#)
map z#  <Plug>(asterisk-z*)
map gz# <Plug>(asterisk-gz*)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ lambdalisue/suda.vim                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:suda_smart_edit = 0
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ andymass/vim-matchup                                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:matchup_matchparen_enabled = 0
let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 1
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
nmap <M-/><M-/> <Plug>(esearch)
map  <M-/>      <Plug>(esearch-prefill)
let g:esearch = {}
" Use regex matching with the smart case mode by default and avoid matching text-objects.
let g:esearch.regex = 1
let g:esearch.textobj = 0
let g:esearch.case = 'smart'
" Set the initial pattern content using the highlighted search pattern (if
" v:hlsearch is true), the last searched pattern or the clipboard content.
let g:esearch.prefill = ['hlsearch', 'last', 'clipboard']
" Override the default files and directories to determine your project root. Set
" to blank to always use the current working directory.
let g:esearch.root_markers = ['.git', 'Makefile', 'node_modules']
" Prevent esearch from adding any default keymaps.
let g:esearch.default_mappings = 0
" Open the search window in a vertical split and reuse it for all searches.
let g:esearch.win_new = {-> esearch#buf#goto_or_open('[Search]', 'vnew') }
" " Redefine the default highlights (see :help highlight and :help esearch-appearance)
hi esearchHeader gui=bold
hi link esearchStatistics esearchFilename
hi link esearchFilename Label
hi esearchMatch gui=underline,italic,bold guifg=#6C7E96 guibg=#002D59
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ romgrk/barbar.nvim                                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <Tab> :BufferNext<CR>
nnoremap <silent> <S-Tab> :BufferPrevious<CR>
nnoremap <silent> <leader><Tab> :b#<CR>
nnoremap <silent> <M-1> :BufferGoto 1<CR>
nnoremap <silent> <M-2> :BufferGoto 2<CR>
nnoremap <silent> <M-3> :BufferGoto 3<CR>
nnoremap <silent> <M-4> :BufferGoto 4<CR>
nnoremap <silent> <M-5> :BufferGoto 5<CR>
" Colorscheme settings
let bg_current = get(nvim_get_hl_by_name('Normal', 1), 'background', '#000000')
let bg_visible = get(nvim_get_hl_by_name('TabLineSel', 1), 'background', '#000000')
let bg_inactive = get(nvim_get_hl_by_name('TabLine', 1), 'background', '#000000')
" For the current active buffer
hi default link BufferCurrent Search
" For the current active buffer when modified
hi default link BufferCurrentMod Search
" For the current active buffer icon
hi default link BufferCurrentSign Search
" For the current active buffer target when buffer-picking
exe 'hi default BufferCurrentTarget guifg=red gui=bold guibg=' . bg_current
" For buffers visible but not the current one
hi default link BufferVisible TabLineSel
hi default link BufferVisibleMod TabLineSel
hi default link BufferVisibleSign TabLineSel
exe 'hi default BufferVisibleTarget guifg=red gui=bold guibg=' . bg_visible
" For buffers invisible buffers
hi default link BufferInactive TabLine
hi default link BufferInactiveMod TabLine
hi default link BufferInactiveSign TabLine
exe 'hi default BufferInactiveTarget guifg=red gui=bold guibg=' . bg_inactive
" For the shadow in buffer-picking mode
hi default BufferShadow guifg=#000000 guibg=#000000
let bufferline = {}
let bufferline.shadow = v:false
let bufferline.icons = v:true
let bufferline.clickable = v:false
let bufferline.closable = v:false
let bufferline.semantic_letters = v:true
let bufferline.letters = 'aqwert'
let bufferline.animation = v:false
let bufferline.maximum_padding = 1
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ romgrk/todoist.nvim                                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
let todoist = {
      \ 'icons': {
      \   'unchecked': '  ',
      \   'checked':   '  ',
      \   'loading':   '  ',
      \   'error':     '  ',
      \ },
      \}
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ romgrk/nvim-web-devicons                                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = 'ﰆ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.lock.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack\.'] = 'ﰩ'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ █▓▒░ Yggdroot/indentLine                                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui = '#18263d'
let g:indentLine_enabled = 0
