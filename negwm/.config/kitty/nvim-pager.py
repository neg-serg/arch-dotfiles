#!/usr/bin/env python

import argparse
import fileinput
import os
from pathlib import Path
from subprocess import Popen
from typing import Tuple

from pynvim import Nvim, attach
from pynvim.api.buffer import Buffer

NVIM_CMD = [
    "/usr/bin/env",
    "nvim",
    "--cmd", "set shortmess+=I",            # Do not display intro message
    "--cmd", "set clipboard+=unnamedplus",  # Use system clipboard by default
    "--noplugin",
]

WINDOW_OPTIONS = {
    "number": False,
    "relativenumber": False,
}

BUFFER_OPTIONS = {
    "modifiable": False,
    "scrollback": 100000,
}


def _launch_nvim() -> Tuple[Popen, Nvim]:
    """
    Launch Neovim, and attach to its listen socket.
    """
    # Unique socket name is based on PID of parent process (this Python script)
    socket = Path(f"/run/user/{os.getuid()}/nvim-pager-{os.getpid()}")
    process = Popen(NVIM_CMD + ["--listen", str(socket)])
    while not socket.is_socket():
        pass
    nvim: Nvim = attach("socket", path=socket)
    # Map "q" to quit Neovim
    nvim.api.set_keymap("n", "q", ":qa!<CR>", {"silent": True})
    return process, nvim


def _open_terminal(nvim: Nvim, bufname: str = "") -> int:
    """
    Spawn a jobless terminal, which is just a proxy that can handle ANSI escape
    sequences properly.
    """
    buffer: Buffer = nvim.api.win_get_buf(0)
    channel: int = nvim.api.open_term(buffer, {})
    nvim.api.buf_set_name(0, bufname)
    for option, value in WINDOW_OPTIONS.items():
        nvim.api.win_set_option(0, option, value)
    for option, value in BUFFER_OPTIONS.items():
        nvim.api.buf_set_option(0, option, value)
    return channel


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "files",
        metavar="FILE",
        nargs="*",
        help="file to display in pager (stdin is used otherwise)",
    )
    parser.add_argument(
        "-n",
        metavar="NAME",
        type=str,
        default="Pager",
        dest="bufname",
        help="buffer name to display in Neovim",
    )
    parser.add_argument(
        "-s",
        action="store_true",
        dest="scroll",
        help="scroll to end of buffer",
    )
    args = parser.parse_args()
    input_files = args.files if len(args.files) > 0 else ("-",)

    # Save (input) buffer to be passed to the pager
    # TODO: Does this make a copy of the data? Can we avoid it?
    data = "\r".join(fileinput.input(files=input_files))

    process, nvim = _launch_nvim()
    channel = _open_terminal(nvim, bufname=args.bufname)
    nvim.api.chan_send(channel, data)
    if args.scroll:
        last_line = nvim.api.buf_line_count(0)
        nvim.api.win_set_cursor(0, (last_line, 0))
        pass

    # Close connection to Neovim and wait for Neovim process to terminate
    nvim.close()
    process.wait()


if __name__ == "__main__":
    main()
