#!/usr/bin/python3

""" The MIT License(MIT)
    Copyright(c), Tobey Peters, https://github.com/tobeypeters
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software
	and associated documentation files (the "Software"), to deal in the Software without restriction,
	including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
	and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
	subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
	LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

""" cava_visualizer.py
    Description:
        This script converts cava's data output into fancy little bars. These values can range from 0 to 100
        Distributed characters '▁▂▃▄▅▆▇█'.
    Original Author : H45H74X
             reddit : https://www.reddit.com/user/H45H74X/
             Script : https://gitlab.com/linuxstuff/dotfiles/-/blob/master/.config/polybar/scripts/modules/cava.py
"""

from argparse import ArgumentParser, Namespace as arg_namespace, RawTextHelpFormatter
from os import linesep, mkfifo, path, remove
from struct import unpack
from sys import exit, stdout
from time import sleep

parser: ArgumentParser = ArgumentParser(description="cava polybar parse script\nConverts cava raw " + \
    "values into characters and outputs to STDOUT or a fifo buffer." + \
    "\n\nConfiguration file : ~/.config/cava/polybar.conf" + \
    "\n\nNote: If you do not have a copy of the configuration file, this script " + \
    "\nspecifies the minimum needed to create it.", formatter_class=RawTextHelpFormatter)

parser.add_argument('-t', '-test', action='store_true', help='Run test mode (stdout only)')
parser.add_argument('-c', '-colors', nargs=2, help='Override the background and foreground colors.')

args: arg_namespace = parser.parse_args()

""" For this script to work, you need to make sure sure
    an instance of cava is running.
    For example, in a i3 configuration, you could have something like:
    exec --no-startup-id cava -p ~/.config/cava/polybar.conf
    Path of the temporary cava configuration.
    Contents of the config:
    [general]
    bars = 16
    overshoot = 0
    [output]
    method = raw
    channels = mono
    mono_option = average
    raw_target = /tmp/cava_polybar_input.fifo
    bit_format = 8bit
    [smoothing]
    integral = 0
    CAVA_CONFIG_PATH = '/tmp/cava_polybar.config'
"""

""" The 'BAR_FACTOR' is used to calculate all those states and keep the code readable
    (See 'BAR_CHARACTERS')
"""
BAR_FACTOR = 100 / 7

# Characters to display in the visualizer.
BC = [ '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' ]

""" Configure resolution and style of the output here.
    The script fetches the cava output value and searches for the biggest
    matching key to get the character from
    (See 'BAR_FACTOR')
"""
BAR_CHARACTERS = dict([
    (000, BC[0]),  # Zero output

    (BAR_FACTOR * 1, BC[1]),
    (BAR_FACTOR * 2, BC[2]),
    (BAR_FACTOR * 3, BC[3]),
    (BAR_FACTOR * 4, BC[4]),
    (BAR_FACTOR * 5, BC[5]),
    (BAR_FACTOR * 6, BC[6]),

    (100, BC[7]),  # Highest output
])

def valueToCharacter(value) -> None:
    """ Returns the respective character for specified value.
        Args: value ([int]): Value that should be mapped to a character
    """
    return BAR_CHARACTERS[BAR_FACTOR * (value // BAR_FACTOR)] if value < 100 else BAR_CHARACTERS[100]

if args.t:
    # Prints test data to stdout. Useful for checking resolution and customisation configuration

    print('\nBar Characters:')
    for BT, BC in BAR_CHARACTERS.items():
        print(f'{BT:06.2f}: {BC}')

    print('\nValue Test:')
    for i in range(101):
        print(f'{i:03d}: {valueToCharacter(i)}')

    exit(0)

# Separator Character between bars.
SEPARATOR = ' '

# Display no output if all bars are at minimum level (no sound output).
HIDE_WHEN_EMPTY = True

# Specify how long this script should wait before printing another value.
OUTPUT_DELAY = 0.0000

""" Specify how many times cava can report 'no sound' (all values are 0)
    before the script detects it.
"""
EMPTY_OUTPUT_THRESHOLD = 10

""" The following data will be used in the temporary cava config.
    FIFO input pipe for raw cava data
    PIPE_IN = path.join(sep, 'tmp', 'cava_polybar_input.fifo')
    NOTE: I created and RAMDISK on my system for "trash" files like this.
        Keep from hitting the SSD constantly
"""
# PIPE_IN = '/tmp/cava_polybar_input.fifo'
PIPE_IN = '/mnt/ram_disk/cava_polybar_input.fifo'

# Number of bars in cava.  Default: 8
CAVA_BARS_NUMBER = 16

# Output bit format for cava. Can be 16bit ot 8bit.
CAVA_BIT_FORMAT = '8bit'

bytetype, bytesize, bytenorm = ('H', 2, 65535) if (
    CAVA_BIT_FORMAT == '16bit') else ('B', 1, 255)

def output(string) -> None:
    def colorizeText(formatStr: str, formatColors: list[str]) -> str:
        return f'%{{B{formatColors[0]}}}%{{F{formatColors[1]}}}{formatStr}%{{B- F-}}'

    """
    Write the string to STDOUT
    Args: string ([string]): String to print
    """
    print(string if not args.c else colorizeText(string, args.c), flush=True)

    sleep(OUTPUT_DELAY)

exitCode = 0

if path.exists(PIPE_IN):
    inputPipe = open(PIPE_IN, 'rb')

    chunk = bytesize * CAVA_BARS_NUMBER

    # oldchunks = [BC[0]] * (bytesize * 8)

    emptyOutputs = 0

    while True:
        rawData = inputPipe.read(chunk)
        if len(rawData) < chunk:
            break

        tstring = ''
        emptyOutput = True

        for i in unpack(bytetype * CAVA_BARS_NUMBER, rawData):
            value = int(i / bytenorm * 100)

            if not (tstring == ''):
                tstring += SEPARATOR

            tstring += valueToCharacter(value)

            emptyOutput = (value == 0)

        emptyOutputs += 1 if (emptyOutput and HIDE_WHEN_EMPTY) else -emptyOutputs

        output(f"{' ' if (emptyOutputs > EMPTY_OUTPUT_THRESHOLD) else tstring}{linesep}")

    # Close input pipe
    inputPipe.close()

# Exit with a success code
exit(0)
