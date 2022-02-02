#!/usr/bin/env python
import os
import neovim

nvim = neovim.attach('tcp', address='localhost', port=7777)
nvim.vars['__autocd_cwd'] = os.getcwd()
nvim.command('execute "lcd" fnameescape(g:__autocd_cwd)')
del nvim.vars['__autocd_cwd']
