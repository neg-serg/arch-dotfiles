let s:dark       = '#0b0b12'
let s:light      = '#899CA1'
let s:linenr_bg  = 'NONE'
let s:clinenr_fg = '#899CA1'
let s:red        = '#b33939'
let s:yellow     = '#808021'
let s:magenta    = '#7F62B3'
let s:green      = '#218058'
let s:blue       = '#0F4170'
let s:error      = '#ff0000'
let s:more_dark  = '#080812'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:light, s:blue, 'bold' ],   [ s:light, s:dark ] ]
let s:p.normal.right    = [ [ s:light, s:blue ],   [ s:light, s:dark ] ]
let s:p.normal.middle   = [ [ s:clinenr_fg, s:linenr_bg ] ]
let s:p.normal.error    = [ [ s:error, s:linenr_bg ] ]
let s:p.normal.warning  = [ [ s:light, s:linenr_bg ] ]

let s:p.insert.left     = [ [ s:light, s:green ], [ s:light, s:dark ] ]
let s:p.replace.left    = [ [ s:light, s:red ], [ s:light, s:dark ] ]
let s:p.visual.left     = [ [ s:light, s:magenta], [ s:light, s:dark ] ]

let s:p.tabline.left    = [ [ s:light, s:dark ] ]
let s:p.tabline.tabsel  = [ [ s:light, s:blue ] ]
let s:p.tabline.middle  = [ [ s:light, s:dark ] ]
let s:p.tabline.right   = [ [ s:light, s:blue ], [ s:light, s:dark ] ]

let s:p.inactive.right  = [ [ s:light, s:linenr_bg ], [ s:light, s:linenr_bg ] ]
let s:p.inactive.left   = [ [ s:light, s:linenr_bg ], [ s:light, s:linenr_bg ] ]
let s:p.inactive.middle = [ [ s:light, s:linenr_bg ] ]

let g:lightline#colorscheme#neg#palette = lightline#colorscheme#fill(s:p)
