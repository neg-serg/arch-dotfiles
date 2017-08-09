#!/usr/bin/env python3

""" i3 focus last client

Usage:
  flast.py switch
  flast.py (-h | --help)
  flast.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from docopt import docopt
import os.path

name='flastd-i3'
fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/'+name+'.fifo'))

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 alt-tabber')
    possible_commands=["switch"]

    for i in argv:
        if argv[i] and i in set(possible_commands):
            with open(fifo_,"w") as fp:
                fp.write(i+"\n")
