" !::exe [setf vim]
let b:comment_syntax = 1

" Syntax:
" Key: match commentTitle   contained /\v^\W+\zs\w.+:/
" @tag
" Note
" DONE
" TODO
" FIXME
" XXX
" WATCHME
" DEPRECATED

syntax match commentTag     contained /\v\@\w+/
syntax match commentDoc     contained /\v\@\w+\ze\s*:/
syntax match commentDesc    contained /\v.+$/
syntax match commentSection contained /\v^\s*.?\zs\s+[A-Z][^:]+:\ze\W*\n/
syntax match commentLabel   contained /\v^\s*.?\s+\zs[A-Z][^:]+:\ze/ contains=commentDoc nextgroup=commentDesc

syntax keyword commentNote       contained NOTE Note
syntax keyword commentDone       contained DONE Done
syntax keyword commentDeprecated contained DEPRECATED
syntax keyword commentTodo       contained TODO
syntax keyword commentWatch      contained WATCHME
syntax keyword commentFixme      contained FIXME
syntax keyword commentXXX        contained XXX URGENT

syntax cluster Comment contains=
            \commentSection,commentLabel,commentTitle,commentTag,
            \commentTodo,commentDone,commentNote,
            \commentWatch,commentFixme,commentXXX,commentDeprecated
syntax cluster comments contains=
            \commentSection,commentLabel,commentTitle,commentTag,
            \commentTodo,commentDone,commentNote,
            \commentWatch,commentFixme,commentXXX,commentDeprecated

hi! link commentTag        Tag
hi! link commentSection    CommentTitle
hi! link commentLabel      CommentTitle
hi! link commentDoc        SpecialComment
hi! link commentDesc       Comment
hi! link commentTitle      Title
hi! link commentNote       TextInfoBold
hi! link commentTodo       TextWarningBold
hi! link commentDone       TextSuccessBold
hi! link commentWatch      TextSpecialBold
hi! link commentXXX        TextErrorBold
hi! link commentFixme      TextWarningBold
hi! link commentDeprecated TextMutedBold

