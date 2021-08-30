#!/usr/bin/env python
import os
import neovim

nvim = neovim.attach('socket', path='/tmp/nvimsocket')
nvim.vars['__autocd_cwd'] = os.getcwd()
nvim.command('execute "lcd" fnameescape(g:__autocd_cwd)')
del nvim.vars['__autocd_cwd']
