" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
    finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
    let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl NONE
endfunction

function! s:system(cmd) " execute external command async if possible
    if exists('g:loaded_vimproc')
        call vimproc#system(a:cmd)
    else
        call system(a:cmd)
    endif
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
    if empty(a:buffer)
        let btarget = bufnr('%')
    elseif a:buffer =~ '^\d\+$'
        let btarget = bufnr(str2nr(a:buffer))
    else
        let btarget = bufnr(a:buffer)
    endif
    if btarget < 0
        call s:Warn('No matching buffer for '.a:buffer)
        return
    endif
    if empty(a:bang) && getbufvar(btarget, '&modified')
        call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
        return
    endif
    " Numbers of windows that view target buffer which we will delete.
    let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
    if !g:bclose_multiple && len(wnums) > 1
        call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
        return
    endif
    let wcurrent = winnr()
    for w in wnums
        execute w.'wincmd w'
        let prevbuf = bufnr('#')
        if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
            buffer #
        else
            bprevious
        endif
        if btarget == bufnr('%')
            " Numbers of listed buffers which are not the target to be deleted.
            let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
            " Listed, not target, and not displayed.
            let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
            " Take the first buffer, if any (could be more intelligent).
            let bjump = (bhidden + blisted + [-1])[0]
            if bjump > 0
                execute 'buffer '.bjump
            else
                execute 'enew'.a:bang
            endif
        endif
    endfor
    execute 'bdelete'.a:bang.' '.btarget
    execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')

function! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

function! DelDel()
    " Do not copy to default register on delete/change
    for key in ['d', 'D', 'c', 'C']
        for keymode in ['n', 'v']
            exe keymode . 'noremap ' . key . ' "_' . key
        endfor
    endfor
endfunction

" Source/execute current line/selection/operator-pending.
" This uses a temporary file instead of "exec", which does not handle
" statements after "endfunction".
fun! SourceViaFile() range
    echom "first/last" a:firstline a:lastline
    let tmpfile = tempname()
    exe a:firstline.",".a:lastline."w ".tmpfile
    exe "source" tmpfile
    if &verbose
        echom "Sourced ".(a:lastline - a:firstline + 1)." lines."
    endif
endfun
command! -range SourceThis <line1>,<line2>call SourceViaFile()

" Setup titlestring on BufEnter, when v:servername is available.
fun! MySetupTitleString()
    let &titlestring = '✐ '

    let session_name = MyGetSessionName()
    if len(session_name)
        let &titlestring .= '['.session_name.'] '
    else
        " Add non-default servername to titlestring.
        let sname = MyGetNonDefaultServername()
        if len(sname)
            let &titlestring .= '['.sname.'] '
        endif
    endif

    " Call the function and use its result, rather than including it.
    " (for performance reasons).
    let &titlestring .= substitute(
                \ ShortenFilenameWithSuffix('%', 15).' ('.ShortenPath(getcwd()).')',
                \ '%', '%%', 'g')

    " Easier to type/find than the unicode symbol prefix.
    let &titlestring .= ' - vim'

    " Append $_TERM_TITLE_SUFFIX (e.g. user@host) to title (set via zsh, used
    " with SSH).
    if len($_TERM_TITLE_SUFFIX)
        let &titlestring .= $_TERM_TITLE_SUFFIX
    endif

    " Setup tmux window name, see ~/.dotfiles/oh-my-zsh/lib/termsupport.zsh.
    if len($TMUX)
                \ && (!len($_tmux_name_reset) || $_tmux_name_reset != $TMUX . '_' . $TMUX_PANE)
        let tmux_auto_rename=systemlist('tmux show-window-options -t '.$TMUX_PANE.' -v automatic-rename 2>/dev/null')
        " || $(tmux show-window-options -t $TMUX_PANE | grep '^automatic-rename' | cut -f2 -d\ )
        " echom string(tmux_auto_rename)
        if !len(tmux_auto_rename) || tmux_auto_rename[0] != "off"
            " echom "Resetting tmux name to 0."
            call system('tmux set-window-option -t '.$TMUX_PANE.' -q automatic-rename off')
            call system('tmux rename-window -t '.$TMUX_PANE.' 0')
        endif
    endif

    " Make Vim set the window title according to &titlestring.
    if !has('gui_running') && empty(&t_ts)
        if len($TMUX)
            let &t_ts = "\e]2;"
            let &t_fs = "\007"
        elseif &term =~ "^screen.*"
            let &t_ts="\ek"
            let &t_fs="\e\\"
        endif
    endif

    " Set icon text according to &titlestring (used for minimized windows).
    let &iconstring = '(v) '.&titlestring
endfun


" Shorten a given filename by truncating path segments.
let g:_cache_shorten_filename = {}
function! ShortenFilename(...)
    " Args: bufname ('%' for default), maxlength
    " echomsg "ShortenFilename:" string(a:000)

    " get bufname from a:1, defaulting to bufname('%')
    if a:0 && a:1 != '%'
        let bufname = a:1
    else
        let bufname = bufname("%")
        if !len(bufname)
            if &bt != '' && len(&ft)
                " Use &ft for name (e.g. with 'startify' and quickfix windows).
                let alt_name = expand('#')
                if len(alt_name)
                    return '['.&ft.'] '.ShortenFilename(expand('#'))
                else
                    return '['.&ft.']'
                endif
            else
                " TODO: get Vim's original "[No Name]" somehow
                return '[No Name]'
            endif
        end

        if getbufvar(bufnr(bufname), '&filetype') == 'help'
            return '[?] '.fnamemodify(bufname, ':t')
        endif

        if bufname =~ '^__'
            return bufname
        endif
    endif

    " Maxlen from a:2 (used for cache key) and caching.
    let maxlen = a:0>1 ? a:2 : max([10, winwidth(0)-50])
    " echom maxlen a:0
    " if a:0>1 | echom a:2 | endif

    " Check for cache (avoiding fnamemodify):
    let cache_key = bufname.'::'.getcwd().'::'.maxlen
    if has_key(g:_cache_shorten_filename, cache_key)
        return g:_cache_shorten_filename[cache_key]
    endif

    " Make path relative first, which might not work with the result from
    " `shorten_path`.
    let rel_path = fnamemodify(bufname, ":.")
    let bufname = ShortenPath(rel_path, getcwd())

    " Loop over all segments/parts, to mark symlinks.
    " XXX: symlinks get resolved currently anyway!?
    " NOTE: consider using another method like http://stackoverflow.com/questions/13165941/how-to-truncate-long-file-path-in-vim-powerline-statusline
    let maxlen_of_parts = 7 " including slash/dot
    let maxlen_of_subparts = 5 " split at dot/hypen/underscore; including split

    let s:PS = exists('+shellslash') ? (&shellslash ? '/' : '\') : "/"
    let parts = split(bufname, '\ze['.escape(s:PS, '\').']')
    let i = 0
    let n = len(parts)
    let wholepath = '' " used for symlink check
    while i < n
        let wholepath .= parts[i]
        " Shorten part, if necessary:
        if i < n-1 && len(bufname) > maxlen && len(parts[i]) > maxlen_of_parts
            " Let's see if there are dots or hyphens to truncate at, e.g.
            " 'vim-pkg-debian' => 'v-p-d…'
            let w = split(parts[i], '\ze[._-]')
            if len(w) > 1
                let parts[i] = ''
                for j in w
                    if len(j) > maxlen_of_subparts-1
                        let parts[i] .= j[0:maxlen_of_subparts-2]."…"
                    else
                        let parts[i] .= j
                    endif
                endfor
            else
                let parts[i] = parts[i][0:maxlen_of_parts-2].'…'
            endif
        endif
        " Add indicator if this part of the filename is a symlink.
        if getftype(wholepath) == "link"
            if parts[i][0] == s:PS
                let parts[i] = parts[i][0] . '↬ ' . parts[i][1:]
            else
                let parts[i] = '↬ ' . parts[i]
            endif
        endif
        let i += 1
    endwhile
    let r = join(parts, '')
    let g:_cache_shorten_filename[cache_key] = r
    " echom "ShortenFilename" r
    return r
endfunction

" Shorten filename, and append suffix(es), e.g. for modified buffers.
fun! ShortenFilenameWithSuffix(...)
    let r = call('ShortenFilename', a:000)
    if &modified
        let r .= ',+'
    endif
    return r
endfun

fun! MyGetSessionName()
    " Use / auto-set g:MySessionName
    if (!exists("g:MySessionName") || !len(g:MySessionName)) && exists('v:this_session')
        let g:MySessionName = fnamemodify(v:this_session, ':t:r')
    endif
    return g:MySessionName
endfun

" Shorten filename, and append suffix(es), e.g. for modified buffers.
fun! ShortenFilenameWithSuffix(...)
    let r = call('ShortenFilename', a:000)
    if &modified
        let r .= ',+'
    endif
    return r
endfun

" Shorten a given (absolute) file path, via external `shorten_path` script.
" This mainly shortens entries from Zsh's `hash -d` list.
let s:_cache_shorten_path = {}
fun! ShortenPath(path, ...)
    if ! len(a:path)
        return ''
    endif
    let base = a:0 ? a:1 : ""
    let cache_key = base . ":" . a:path
    if ! exists('s:_cache_shorten_path[cache_key]')
        let s:_cache_shorten_path[cache_key] = system('~/bin/scripts/shorten_path '.shellescape(a:path).' '.shellescape(base))
    endif
    return s:_cache_shorten_path[cache_key]
endfun

fun! MyGetNonDefaultServername()
    " Not for gvim in general (uses v:servername by default), and the global
    " server ("G").
    let sname = v:servername
    if len(sname)
        if has('nvim')
            if sname !~# '^/tmp/nvim'
                return sname
            endif
        elseif sname !~# '\v^GVIM.*' " && sname =~# '\v^G\d*$'
            return sname
        endif
    endif
    return ''
endfun

fun! MyGetSessionName()
    " Use / auto-set g:MySessionName
    if (!exists("g:MySessionName") || !len(g:MySessionName)) && exists('v:this_session')
        let g:MySessionName = fnamemodify(v:this_session, ':t:r')
    endif
    return g:MySessionName
endfun

fun! Ranger()
  let tmpfile = tempname()
  if a:0 > 0 && a:1 != ""
    let dir = a:1
  elseif expand("%")
    let dir = "."
  else
    let dir = expand("%:p:h")
  endif

  exe 'silent !ranger --choosefile='.tmpfile dir
  if filereadable(tmpfile)
    exe 'edit' readfile(tmpfile)[0]
    call delete(tmpfile)
  endif
  redraw!

  let result = 0
  if filereadable(tmpfile)
      silent let result = system('cat '. tmpfile)
  endif
  silent call system('rm -rf ' . tmpfile)
  return result
endfun

function! ToggleOptionFlag(option, flag)
  execute 'let l:value = &' . a:option
  let l:operator = l:value =~ a:flag ? '-=' : '+='
  execute 'setlocal' a:option . l:operator . a:flag
endfunction

function! ToggleOptionFlags(option, flags)
  map(flags, 'call ToggleOptionFlag(a:option, v:val)')
endfunction

function! DequoteLang()
    %s/[‘’]/'/|s/[“”¿¿]/\"/
endfunction

function! Ienter() abort
if pumvisible()
    return "\<c-y>"
elseif getline('.')[col('.') - 2]==#'{'&&getline('.')[col('.')-1]==#'}'
    return "\<Enter>\<esc>ko"
else
    return "\<Enter>"
endif
endfunction

function! ChangeBack()
    :hi CursorColumn ctermbg=12
    :setlocal colorcolumn=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256
endfunction

function! GetFt()
    if &filetype == "nerdtree"
        :call ChangeBack()
    endif
endfunction
