" Vim syntax file
" Language:	Quickfix window
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Jan 15

" Quit when a syntax file was already loaded
" if exists("b:current_syntax")
  " finish
" endif

setlocal conceallevel=3
setlocal concealcursor=nvic

syn match	qfError		"error"  contained
syn match	qfWarning	"warning"  contained
" A bunch of useful C keywords
syn match	qfFileName	"^[^|]*" contains=qfLineNr,qfDesc,qfError,qfWarning
"syn match	qfSeparator	"|" nextgroup=qfLineNr contained conceal
syn region	qfLineNr	start=/|/ end=/|/  contains=qfError,qfWarning
"syn match	qfDesc		" [^:]*:" contains=qfError,qfWarning contained
"syn match	qfLineNr	"[^|]*" nextgroup=qfSeparator contained contains=qfError

syn region	qfLogs start=/^||/me=s end=/^[^|]/me=s-1 contains=qfEmpty,qfLog,qfPointer transparent fold

syn match       qfEmpty		"||" nextgroup=qfLog,qfPointer contained conceal
syn match       qfLog		"\s*[^^].*" contained
syn match	qfPointer	"\s*\^\s*" contained

" The default highlighting.
hi! link qfFileName	Comment
hi! link qfLineNr	Comment
hi! link qfPointer	BoldDebug
hi! link qfError	BoldError
hi! link qfWarning	BoldWarning
hi! link qfLog	Comment

let b:current_syntax = "qf"

" vim: ts=8
