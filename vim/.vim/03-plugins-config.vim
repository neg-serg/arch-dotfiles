" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - neoclide/coc.nvim                                                        │
" │ https://github.com/neoclide/coc.nvim                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Using CocList
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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-session                                                        │ 
" │ https://github.com/xolox/vim-session                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
" Remember info about open buffers on close
set viminfo^=%
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
let g:gitgutter_realtime = 1 " github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_async = 1
" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
highlight SignColumn ctermbg=4
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - w0rp/ale                                                                 │ 
" │ https://github.com/w0rp/ale                                                       │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
" ⚡😱✗➽⚑⚐♒⛢❕❗✖➤
let g:ale_sign_warning = '➤ '
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
let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . " " . " --color=16"
if executable('rg')
    let s:rg_cmd = "rg --hidden --follow"
    let s:rg_ignore = split(&wildignore, ',') + [
        \ 'node_modules', 'target', 'build', 'dist', '.stack-work'
        \ ]
    let s:rg_cmd .= " --glob '!{'" . shellescape(join(s:rg_ignore, ',')) . "'}'"

    let &grepprg=s:rg_cmd . ' --vimgrep'
    let $FZF_DEFAULT_COMMAND = 'rg --files'
    command! -bang -nargs=* Rg call fzf#vim#grep(s:rg_cmd . ' --column --line-number --no-heading --fixed-strings --smart-case --color always ' . shellescape(<q-args>), 1, <bang>0)
    command! -bang -nargs=* Find Rg<bang> <args>
endif

nnoremap qe :Files %:p:h<CR>
nnoremap qE :Files<CR>
nnoremap ed :Buffers<CR>

" This is the default extra key bindings
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

if 1
    let s:layout_top = 1
    if s:layout_top == 1
        let g:fzf_layout = { 'window': 'call FloatingFZF(4, 50, 80, (&lines - 8) / 2)' }
    else
        let g:fzf_layout = { 'window': 'call FloatingFZF(&lines - 8, 50, 80, (&lines - 8) / 2)' }
    endif
else
    let g:fzf_layout = { 'down': '~20%' }
endif

function! FloatingFZF(row, col, width, height)
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')
    let s:height = &lines - 8
    let opts = {'relative': 'editor', 'row': a:row, 'col': a:col, 'width': a:width, 'height': a:height}
    call nvim_open_win(buf, v:true, opts)
endfunction

" For Commits and BCommits to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
\ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

" Insert mode completion
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)

nnoremap <silent> <Leader>. :call fzf#run({
    \ 'source': 'sed "1d" $HOME/.cache/neomru/file',
    \ 'options': '--tiebreak=index --multi --reverse --margin 15%,0',
    \ 'down': '20%',
    \ 'sink': 'e '
    \ })<CR>
function! s:escape(path)
    return substitute(a:path, ' ', '\\ ', 'g')
endfunction
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - SirVer/ultisnips.git                                                     │
" │ https://github.com/SirVer/ultisnips.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:UltiSnipsRemoveSelectModeMappings = 1
let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
let g:UltiSnipsExpandTrigger       = "<NOP>"
let g:UltiSnipsJumpForwardTrigger  = "<C-;>"
let g:UltiSnipsJumpBackwardTrigger = "<C-Tab>"
let g:UltiSnipsListSnippets        = "<c-m-s>"
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:LustyJugglerDefaultMappings = 0
let LustyExplorerDefaultMappings  = 0
nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lyokha/vim-xkbswitch.git                                                 │
" │ https://github.com/lyokha/vim-xkbswitch.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
let g:XkbSwitchSkipFt = ['nerdtree', 'tex']
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - derekwyatt/vim-fswitch.git                                               │
" │ https://github.com/derekwyatt/vim-fswitch.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
" A "companion" file is a .cpp file to an .h file and vice versa
" Opens the companion file in the current window
nnoremap <Space>fs :FSHere<cr>
" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Space>sl :call FSwitch('%', 'wincmd l')<cr>
" Same as above, only opens it in window to the right
nnoremap <Space>sr :call FSwitch('%', 'wincmd r')<cr>
" Creates a new window on the left and opens the companion file in it
nnoremap <Space>sv :FSSplitLeft<cr>
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
let g:lt_location_list_toggle_map = '[Quickfix]S-q'
let g:lt_quickfix_list_toggle_map = '[Quickfix]q'
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
nmap <Space>cc :Make -j10<cr>
nmap <Space>mc :Make distclean<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - luochen1990/rainbow                                                      │
" │ https://github.com/luochen1990/rainbow.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rainbow_active = 1 
let g:rainbow_conf = {
    \   'guifgs': ['#005F87', '#005F5F', '#2B768D', '#395573'],
    \   'ctermfgs': ['cyan', 'darkcyan', 'blue', 'darkblue'],
    \   'operators': '_,_',
    \   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
    \   'separately': {
    \       '*': {},
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
    \       },
    \       'vim': {
    \           'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
    \       },
    \       'tex': {
    \           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
    \       },
    \       'css': 0,
    \       'stylus': 0,
    \   }
    \}
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - joshdick/onedark.vim                                                     │
" │ https://github.com/joshdick/onedark.vim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:onedark_color_overrides = {
    \ "red": { "gui": "#F07178", "cterm": "204", "cterm16": "1" },
    \ "dark_red": { "gui": "#F07178", "cterm": "196", "cterm16": "9" },
    \ "green": { "gui": "#C3E88D", "cterm": "114", "cterm16": "2" },
    \ "yellow": { "gui": "#FFE082", "cterm": "180", "cterm16": "3" },
    \ "dark_yellow": { "gui": "#FFCB6B", "cterm": "173", "cterm16": "11" },
    \ "blue": { "gui": "#82AAFF", "cterm": "39", "cterm16": "4" },
    \ "purple": { "gui": "#C792EA", "cterm": "170", "cterm16": "5" },
    \ "cyan": { "gui": "#89DDF3", "cterm": "38", "cterm16": "6" },
    \ "white": { "gui": "#B2CCD6", "cterm": "145", "cterm16": "7" },
    \ "black": { "gui": "#263238", "cterm": "235", "cterm16": "0" },
    \ "visual_black": { "gui": "NONE", "cterm": "NONE", "cterm16": "0" },
    \ "comment_grey": { "gui": "#4F6875", "cterm": "59", "cterm16": "15" },
    \ "gutter_fg_grey": { "gui": "#3E4A50", "cterm": "238", "cterm16": "15" },
    \ "cursor_grey": { "gui": "#37625A", "cterm": "236", "cterm16": "8" },
    \ "visual_grey": { "gui": "#2D3B42", "cterm": "237", "cterm16": "15" },
    \ "menu_grey": { "gui": "#2D3B42", "cterm": "237", "cterm16": "8" },
    \ "special_grey": { "gui": "#2D3B42", "cterm": "238", "cterm16": "15" },
    \ "vertsplit": { "gui": "#202A2F", "cterm": "59", "cterm16": "15" }
\}
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
if executable('waterfox')
    let g:mkdp_path_to_chrome= get(g:, 'mkdp_path_to_chrome', 'waterfox')
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - itchyny/lightline.vim                                                    │
" │ https://github.com/itchyny/lightline.vim                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
source ~/.vim/10-lightline-config.vim
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - mhinz/vim-grepper                                                        │
" │ https://github.com/mhinz/vim-grepper                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <C-/> :Grepper -tool rg<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - gregsexton/gitv                                                          │
" │ https://github.com/gregsexton/gitv                                                │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:Gitv_OpenHorizontal = 0
