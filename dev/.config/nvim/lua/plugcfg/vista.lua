-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ liuchengxu/vista.vim                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.vista_sidebar_width = 20
vim.g.vista_disable_statusline = 1
vim.g["vista#renderer#enable_icon"] = 1
vim.g.vista_icon_indent = {'▸ ', ''}
vim.g["vista#renderer#icons"] = {
      ['augroup']        = "פּ",
      ['class']          = "",
      ['constant']       = '',
      ['default']        = "",
      ['enum']           = "",
      ['enumerator']     = "",
      ['field']          = "",
      ['fields']         = "",
      ['functions']      = "ﬦ",
      ['function']       = "ﬦ",
      ['func']           = "ﬦ",
      ['implementation'] = "",
      ['interface']      = "",
      ['macro']          = "",
      ['macros']         = "",
      ['map']            = "פּ",
      ['member']         = "",
      ['method']         = "",
      ['module']         = '',
      ['modules']        = "",
      ['namespace']      = "",
      ['package']        = "",
      ['packages']       = "",
      ['property']       = "襁",
      ['struct']         = "",
      ['subroutine']     = "羚",
      ['target']         = "",
      ['type']           = "",
      ['typedef']        = "",
      ['typeParameter']  = "",
      ['types']          = "",
      ['union']          = "鬒",
}
vim.g.vista_default_executive = 'coc'
