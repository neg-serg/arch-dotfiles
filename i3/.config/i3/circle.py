#!/usr/bin/env python3 
""" i3 Named Scratchpads

Usage:
  circle.py next <name>
  circle.py info <name>
  circle.py (-h | --help)
  circle.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from docopt import docopt
import os.path

if __name__ == '__main__':
    name_="circle"
    fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/'+name_+'.fifo'))
    argv = docopt(__doc__, version='i3 cycler over windows')
    if os.path.exists(fifo_):
        possible_commands=["next","info"]

        for i in argv:
            if argv[i] and i in set(possible_commands):
                with open(fifo_,"w") as fp:
                    fp.flush()
                    fp.write(i+" "+argv["<name>"]+"\n")
