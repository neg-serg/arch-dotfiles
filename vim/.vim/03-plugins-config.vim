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
" if !1
"     nnoremap <leader>l :Files %:p:h<CR>
" endif

" Taken from :
" [https://github.com/aliev/vim/blob/master/vimrc]
if executable('ag')
    " Silver searcher instead of grep
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c%m

    " If you're running fzf in a large git repository, git ls-tree can boost up
    " the speed of the traversal.
    if isdirectory('.git') && executable('git')
        let $FZF_DEFAULT_COMMAND='
                    \ (git ls-tree -r --name-only HEAD ||
                    \ find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
                    \ sed s/^..//) 2> /dev/null'
    else
        let $FZF_DEFAULT_COMMAND='ag -g ""'
    endif
endif

nnoremap qe :Files %:p:h<CR>
nnoremap qE :Files<CR>
nnoremap ed :Buffers<CR>
" This is the default extra key bindings
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }

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
let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
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
let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
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
let g:lightline = {
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \              [ 'fugitive', 'filename', 'modified' ]
    \            ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'mode': 'LightlineMode',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding'
    \ },
    \ 'component_visible_condition': {
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
    \ },
    \ 'colorscheme': 'neg',
    \ 'separator': { 'left': '▒', 'right': '▒' },
    \ 'subseparator': { 'left': '∣', 'right': '∣' }
\ }

let g:lightline.component = {
    \ 'mode': '%{lightline#mode()}',
    \ 'absolutepath': '%F',
    \ 'relativepath': '%f',
    \ 'filename': '%t',
    \ 'modified': '%M',
    \ 'bufnum': '%n',
    \ 'paste': '%{&paste?"PASTE":""}',
    \ 'readonly': '%R',
    \ 'charvalue': '%b',
    \ 'charvaluehex': '%B',
    \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
    \ 'fileformat': '%{&ff}',
    \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
    \ 'percent': '%3p%%',
    \ 'percentwin': '%P',
    \ 'spell': '%{&spell?&spelllang:""}',
    \ 'lineinfo': '%3l:%-2v',
    \ 'line': '%l',
    \ 'column': '%c',
    \ 'close': '%999X X ',
    \ 'winnr': '%{winnr()}'
\ }

let g:lightline.mode_map = {
    \ 'n' : 'N',
    \ 'i' : 'INS',
    \ 'R' : 'REPLACE',
    \ 'v' : 'v',
    \ 'V' : 'V',
    \ "\<C-v>": 'vb',
    \ 'c' : 'CMD',
    \ 's' : 'SEL',
    \ 'S' : 'S-LINE',
    \ "\<C-s>": 'S-BLOCK',
    \ 't': 'TERM',
\ }
function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let branch = fugitive#head()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction
function! LightlineFilename()
let fname = expand('%:t')
return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
function! LightlineMode()
let fname = expand('%:t')
return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
augroup LightLineColorscheme
    autocmd!
    autocmd ColorScheme * call s:lightline_update()
augroup END
function! s:lightline_update()
    if !exists('g:loaded_lightline')
        return
    endif
    try
        if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow\|dracula'
            let g:lightline.colorscheme = substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
                        \ (g:colors_name ==# 'solarized' ? '_' . &background : '')
            call lightline#init()
            call lightline#colorscheme()
            call lightline#update()
        endif
    catch
    endtry
endfunction
