let g:airline#themes#wim#palette = {}

let g:airline#themes#wim#palette.accents = {
      \ 'red': [ '#ffffff' , '' , 231 , '' , '' ],
      \ }


let s:N1 = [ '#ffffff' , '#073642' , 231  , 18 ]
let s:N2 = [ '#ffffff' , '#002B36' , 231 , 17 ]
let s:N3 = [ '#ffffff' , '#080808' , 231  , 234 ]
let g:airline#themes#wim#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)


let s:I1 = [ '#ffffff' , '#003623' , 231 , 64 ]
let s:I2 = [ '#ffffff' , '#002B36' , 231 , 17  ]
let s:I3 = [ '#ffffff' , '#080808' , 231 , 234  ]
let g:airline#themes#wim#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#wim#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#003623' , s:I1[2] , 64     , ''     ] ,
      \ }


let g:airline#themes#wim#palette.replace = copy(g:airline#themes#wim#palette.insert)
let g:airline#themes#wim#palette.replace.airline_a = [ s:I2[0]   , '#920000' , s:I2[2] , 124     , ''     ]

let s:V1 = [ '#ffff9a' , '#680020' , 246 , 125 ]
let s:V2 = [ '#ffffff' , '#002B36' , 248 , 17 ]
let s:V3 = [ '#ffffff' , '#080808' , 248  , 234  ]
let g:airline#themes#wim#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA = [ '#4e4e4e' , '#080808' , 240 , 234 , '' ]
let g:airline#themes#wim#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

let g:airline#themes#wim#palette.tabline = {
      \ 'airline_tabsel':  ['#ffffff', '#2e8b57',  231, 77, ''],
      \ 'airline_tabtype':  ['#ffffff', '#073642',  231, 18, ''],
      \ 'airline_tabfill':  ['#ffffff', '#080808',  231, 234, ''],
      \ 'airline_tabmod':  ['#ffffff', '#780000',  231, 126, ''],
      \ }

let s:WI = [ '#ffffff', '#5f0000', 231, 127 ]
let g:airline#themes#wim#palette.normal.airline_warning = [
     \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
     \ ]

let g:airline#themes#wim#palette.insert.airline_warning =
    \ g:airline#themes#wim#palette.normal.airline_warning

let g:airline#themes#wim#palette.visual.airline_warning =
    \ g:airline#themes#wim#palette.normal.airline_warning

let g:airline#themes#wim#palette.replace.airline_warning =
    \ g:airline#themes#wim#palette.normal.airline_warning
