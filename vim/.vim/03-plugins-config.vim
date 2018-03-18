" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-session                                                        │ 
" │ https://github.com/xolox/vim-session                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-session')
    " Remember info about open buffers on close
    set viminfo^=%
    let g:session_autoload = 'yes'
    let g:session_autosave = 'yes'
    let g:session_autosave_to = 'default'
    let g:session_verbose_messages = 0
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - airblade/vim-gitgutter                                                   │ 
" │ https://github.com/airblade/vim-gitgutter                                         │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-gitgutter')
    let g:gitgutter_realtime = 1 " github.com/airblade/vim-gitgutter/issues/106
    let g:gitgutter_async = 1
    " GitGutter styling to use · instead of +/-
    let g:gitgutter_sign_added = '∙'
    let g:gitgutter_sign_modified = '∙'
    let g:gitgutter_sign_removed = '∙'
    let g:gitgutter_sign_modified_removed = '∙'
    highlight SignColumn ctermbg=4
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - w0rp/ale                                                                 │ 
" │ https://github.com/w0rp/ale                                                       │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('ale')
    " ⚡😱✗➽⚑⚐♒⛢❕❗✖➤
    let g:ale_sign_warning = '➤ '
    let g:ale_sign_error = '✖'

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    highlight link ALEWarningSign String
    highlight link ALEErrorSign Title
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - junegunn/fzf.vim                                                         │ 
" │ https://github.com/junegunn/fzf.vim                                               │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('fzf.vim')
    if !has("nvim")
        let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . " " . " --color=16"
    else
        let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . " " . " --color=16"
    endif
    if !dein#tap('lusty') && !dein#tap('lycosaexplorer') && has("nvim")
        nnoremap <leader>l :Files %:p:h<CR>
    endif

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
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - SirVer/ultisnips.git                                                     │
" │ https://github.com/SirVer/ultisnips.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('ultisnips')
    let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
    if has("gui_macvim")
        " Ctrl conflicts with Dvorak-Qwerty Command
        let g:UltiSnipsExpandTrigger       = "<m-s>"
    else
        let g:UltiSnipsExpandTrigger       = "<m-s>"
        let g:UltiSnipsJumpForwardTrigger  = "<m-s>"
        let g:UltiSnipsJumpBackwardTrigger = "<m-f>"
        let g:UltiSnipsListSnippets        = "<c-m-s>"
    endif
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('lusty')
    let g:LustyJugglerDefaultMappings = 0
    let LustyExplorerDefaultMappings  = 0
    nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lyokha/vim-xkbswitch.git                                                 │
" │ https://github.com/lyokha/vim-xkbswitch.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-xkbswitch')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
    let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Shougo/deoplete.nvim                                                     │
" │ https://github.com/Shougo/deoplete.nvim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('deoplete.nvim')
    if has("nvim")
        let g:deoplete#enable_at_startup = 1 
    endif
    let g:deoplete#ignore_sources      = {}
    let g:deoplete#omni#input_patterns = {}
    let g:deoplete#omni_patterns       = {}

    let g:deoplete#enable_at_startup     = 1
    let g:deoplete#enable_ignore_case    = 1
    let g:deoplete#enable_smart_case     = 1
    let g:deoplete#enable_camel_case     = 1
    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#max_abbr_width        = 0
    let g:deoplete#max_menu_width        = 0

    let g:deoplete#complete_method   = "complete"
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#max_list          = 500
    let g:deoplete#max_menu_width    = 8

    " java && jsp
    let g:deoplete#omni#input_patterns.java = [
                \'[^. \t0-9]\.\w*',
                \'[^. \t0-9]\->\w*',
                \'[^. \t0-9]\::\w*',
                \]
    let g:deoplete#omni#input_patterns.jsp = ['[^. \t0-9]\.\w*']

    " perl
    let g:deoplete#omni#input_patterns.perl = [
                \'[^. \t0-9]\.\w*',
                \'[^. \t0-9]\->\w*',
                \'[^. \t0-9]\::\w*',
                \]

    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
    set isfname-==

    " deoplete tab-complete
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
    inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<Tab>"
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - majutsushi/tagbar.git                                                    │
" │ https://github.com/majutsushi/tagbar.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('tagbar')
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
        \ ]
    \ }
    let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
        \ 'kinds' : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
        \ ]
    \ }
    let g:tagbar_type_ruby = {
        \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'f:methods',
            \ 'F:singleton methods'
        \ ]
    \ }
    let g:tagbar_width   = 30
    let g:tagbar_left    = 0
    let g:tagbar_sort    = 0
    let g:tagbar_compact = 1
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - derekwyatt/vim-fswitch.git                                               │
" │ https://github.com/derekwyatt/vim-fswitch.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-fswitch')
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
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - chrisbra/Join.git                                                        │
" │ https://github.com/chrisbra/Join.git                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('Join')
    nmap J :Join<CR>
    vmap J :Join<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - gregsexton/gitv.git                                                      │
" │ https://github.com/gregsexton/gitv.git                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('gitv')
    let g:Gitv_OpenHorizontal      = 'auto'
    let g:Gitv_OpenPreviewOnLaunch = 1
    let g:Gitv_WipeAllOnClose      = 1
    let g:Gitv_DoNotMapCtrlKey     = 1
    let g:Gitv_CommitStep          = 1024
    nnoremap <silent> <leader>gv :Gitv --all<CR>
    nnoremap <silent> <leader>gV :Gitv! --all<CR>
    vnoremap <silent> <leader>gV :Gitv! --all<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Valloric/ListToggle.git                                                  │
" │ https://github.com/Valloric/ListToggle.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('ListToggle')
    let g:lt_height = 10
    let g:lt_location_list_toggle_map = '[Quickfix]S-q'
    let g:lt_quickfix_list_toggle_map = '[Quickfix]q'
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Raimondi/delimitMate.git                                                 │
" │ https://github.com/Raimondi/delimitMate.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('delimitMate')
    let g:delimitMate_expand_space       = 1
    let g:delimitMate_expand_cr          = 0
    let g:delimitMate_smart_quotes       = 1
    let g:delimitMate_balance_matchpairs = 1
    imap <Esc>OH <Plug>delimitMateHome
    imap <Esc>OF <Plug>delimitMateEnd
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Shougo/vimfiler.vim                                                      │
" │ https://github.com/Shougo/vimfiler.vim                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vimfiler.vim')
    let g:vimfiler_as_default_explorer    = 1
    let g:vimfiler_restore_alternate_file = 1
    let g:vimfiler_tree_indentation       = 1
    let g:vimfiler_tree_leaf_icon         = ''
    let g:vimfiler_tree_opened_icon       = '▼'
    let g:vimfiler_tree_closed_icon       = '▷'
    let g:vimfiler_file_icon              = ''
    let g:vimfiler_readonly_file_icon     = '*'
    let g:vimfiler_marked_file_icon       = '√'
    let g:vimfiler_direction              = 'rightbelow'
    let g:vimfiler_ignore_pattern         = [
        \ '^\.git$',
        \ '^\.DS_Store$',
        \ '^\.init\.vim-rplugin\~$',
        \ '^\.netrwhist$',
        \ '\.class$'
        \]

    let g:vimfiler_quick_look_command = 'gloobus-preview'

    function! s:setcolum() abort
        return 'filetypeicon:gitstatus'
    endfunction

    call vimfiler#custom#profile('default', 'context', {
        \ 'explorer' : 1,
        \ 'winwidth' : 20,
        \ 'winminwidth' : 30,
        \ 'toggle' : 1,
        \ 'auto_expand': 1,
        \ 'direction' : g:vimfiler_direction,
        \ 'explorer_columns' : s:setcolum(),
        \ 'parent': 0,
        \ 'status' : 1,
        \ 'safe' : 0,
        \ 'split' : 1,
        \ 'hidden': 1,
        \ 'no_quit' : 1,
        \ 'force_hide' : 0,
        \ })

    augroup vfinit
    au!
    autocmd FileType vimfiler call s:vimfilerinit()
    augroup END
    function! s:vimfilerinit()
        setl nonumber
        setl norelativenumber

        silent! nunmap <buffer> <Space>
        silent! nunmap <buffer> <C-l>
        silent! nunmap <buffer> <C-j>
        silent! nunmap <buffer> E
        silent! nunmap <buffer> gr
        silent! nunmap <buffer> gf
        silent! nunmap <buffer> -
        silent! nunmap <buffer> s
    endfunction
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-fugitive.git                                                   │
" │ https://github.com/tpope/vim-fugitive.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
" if dein#tap('vim-fugitive')
"     " ...............
" endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - dbakker/vim-projectroot.git                                              │
" │ https://github.com/dbakker/vim-projectroot.git                                    │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-projectroot')
    nnoremap <silent> cd :ProjectRootCD<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bbchung/gasynctags.git                                                   │
" │ https://github.com/bbchung/gasynctags.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('gasynctags')
    let g:gasynctags_autostart = 0
    nmap <silent><space>d :GasyncTagsEnable<CR>:GtagsCscope<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - othree/eregex.vim.git                                                    │
" │ https://github.com/othree/eregex.vim.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('eregex.vim')
    " With this map, we can select some text in visual mode and by invoking the map,
    " have the selection automatically filled in as the search text and the cursor
    " placed in the position for typing the replacement text. Also, this will ask
    " for confirmation before it replaces any instance of the search text in the
    " file.
    " NOTE: We're using %S here instead of %s; the capital S version comes from the
    " eregex.vim plugin and uses Perl-style regular expressions.
    vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>
    let g:eregex_default_enable    = 0
    " Toggles '/' to mean eregex search or normal Vim search
    nnoremap <leader>/ :call eregex#toggle()<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-dispatch.git                                                   │
" │ https://github.com/tpope/vim-dispatch.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-dispatch')
    nmap MK :Make -j4
    nmap MC :Make clean<cr>
    nmap <Space>cc :Make -j10<cr>
    nmap <Space>mc :Make distclean<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - davidhalter/jedi-vim.git                                                 │
" │ https://github.com/davidhalter/jedi-vim.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('jedi-vim')
    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#usages_command = "<leader>z"
    function! s:jedi_settings()
        nnoremap <buffer><leader>r :<C-u>call jedi#rename()<CR>
        nnoremap <buffer><leader>g :<C-u>call jedi#goto_assignments()<CR>
        nnoremap <buffer><leader>d :<C-u>call jedi#goto_definitions()<CR>
        nnoremap <buffer>K :<C-u>call jedi#show_documentation()<CR>
        nnoremap <buffer><leader>u :<C-u>call jedi#usages()<CR>
        nnoremap <buffer><leader>i :<C-u>Pyimport<leader>
        setlocal omnifunc=jedi#completions
        command! -nargs=0 JediRename call jedi#rename()
    endfunction
    autocmd Filetype python call <SID>jedi_settings()
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - godlygeek/tabular                                                        │ 
" │ git@github.com:godlygeek/tabular                                                  │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('tabular') 
    nmap <Leader>a&     :Tabularize /&<CR>
    vmap <Leader>a&     :Tabularize /&<CR>
    nmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=>    :Tabularize /=><CR>
    vmap <Leader>a=>    :Tabularize /=><CR>
    nmap <Leader>a:     :Tabularize /:<CR>
    vmap <Leader>a:     :Tabularize /:<CR>
    nmap <Leader>a::    :Tabularize /:\zs<CR>
    vmap <Leader>a::    :Tabularize /:\zs<CR>
    nmap <Leader>a,     :Tabularize /,<CR>
    vmap <Leader>a,     :Tabularize /,<CR>
    nmap <Leader>a,,    :Tabularize /,\zs<CR>
    vmap <Leader>a,,    :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - luochen1990/rainbow                                                      │
" │ https://github.com/luochen1990/rainbow.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('rainbow')
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
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - rstacruz/sparkup                                                         │
" │ https://github.com/rstacruz/sparkup                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('sparkup')
    let g:sparkupMapsNormal     = 0       "default = 0
    let g:sparkupMaps           = 0       "default = 1
    let g:sparkupExecuteMapping = "<m-i>" "default = <C-e>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - joshdick/onedark.vim                                                     │
" │ https://github.com/joshdick/onedark.vim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('onedark')
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
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - fatih/vim-go.git                                                         │
" │ https://github.com/fatih/vim-go.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-go')
    let g:go_highlight_functions         = 1
    let g:go_highlight_methods           = 1
    let g:go_highlight_structs           = 1
    let g:go_highlight_operators         = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command                 = 'goimports'
    let g:go_snippet_engine              = 'UltiSnips'
    augroup Go
        au!
        au FileType go nmap <Buffer><silent><Leader>s <Plug>(go-implements)
        au FileType go nmap <Buffer><silent><Leader>i <Plug>(go-info)
        au FileType go nmap <Buffer><silent><Leader>e <Plug>(go-rename)
        au FileType go nmap <Buffer><silent><Leader>r <Plug>(go-run)
        au FileType go nmap <Buffer><silent><Leader>b <Plug>(go-build)
        au FileType go nmap <Buffer><silent><Leader>t <Plug>(go-test)
        au FileType go nmap <Buffer><silent><Leader>gd <Plug>(go-doc)
        au FileType go nmap <Buffer><silent><Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <Buffer><silent><Leader>co <Plug>(go-coverage)
    augroup END
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-markdown                                                       │
" │ https://github.com/tpope/vim-markdown                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-markdown')
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
    if dein#tap('markdown-preview.vim')
        if executable('firefox')
            let g:mkdp_path_to_chrome= get(g:, 'mkdp_path_to_chrome', 'firefox')
        endif
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Yggdroot/indentLine                                                      │
" │ https://github.com/Yggdroot/indentLine                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('indentLine')
    let g:indentLine_enabled                    = 1
    let g:indentLine_setColors                  = 1
    let g:indentLine_color_term                 = 239
    let g:indentLine_char                       = '┆'
    " none X terminal
    let g:indentLine_bgcolor_gui                = '#040404'
    let g:indentLine_concealcursor              = 'inc'
    let g:indentLine_conceallevel               = 2
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - itchyny/lightline.vim                                                    │
" │ https://github.com/itchyny/lightline.vim                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('lightline.vim')
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
        \ 'i' : 'INSERT',
        \ 'R' : 'REPLACE',
        \ 'v' : 'VISUAL',
        \ 'V' : 'V-LINE',
        \ "\<C-v>": 'V-BLOCK',
        \ 'c' : 'COMMAND',
        \ 's' : 'SELECT',
        \ 'S' : 'S-LINE',
        \ "\<C-s>": 'S-BLOCK',
        \ 't': 'TERMINAL',
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
endif
