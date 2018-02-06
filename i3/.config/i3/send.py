#!/usr/bin/python3
""" i3 generic sender

Usage:
  send.py circle reload
  send.py circle next <name>
  send.py circle info <name>
  send.py circle run <name> <subtag>
  send.py ns show <name>
  send.py ns hide <name>
  send.py ns toggle <name>
  send.py ns run <name> <prog>
  send.py ns next
  send.py ns reload
  send.py ns geom_restore
  send.py ns hide_current
  send.py flast switch
  send.py flast reload
  send.py (-h | --help)
  send.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2018

"""

from docopt import docopt
import os.path

conf={
    'circle': {
        'cmds': {
            "next",
            "reload",
            "info",
            "run"
        },
    },
    'ns': {
        'cmds': {
            "show",
            "hide",
            "toggle",
            "next",
            "hide_current",
            "run",
            "geom_restore",
            "reload",
        },
    },
    'flast': {
        'cmds': {
            "switch",
            "reload",
        },
    }
}

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 generic sender')
    script=""
    for sc in conf:
        if argv[sc]:
            script=sc, conf[sc]
            break

    script[1]['fifo'] = os.path.realpath(os.path.expandvars('$HOME/tmp/'+script[0]+'.fifo'))
    if os.path.exists(script[1]['fifo']):
        valid_cmds=script[1]['cmds']
        input_cmds=set([k for k,v in argv.items() if v])

        for fstcmd in valid_cmds & input_cmds:
            break
        fp=os.open(script[1]['fifo'], os.O_WRONLY | os.O_NONBLOCK)
        cmd=""
        if fstcmd is not None:
            cmd+=fstcmd
        for param in ['<name>', '<prog>', '<subtag>']:
            if argv[param]:
                cmd+=" " + argv[param]
        cmd+='\n'
        os.write(fp, str.encode(cmd))
        os.close(fp)
