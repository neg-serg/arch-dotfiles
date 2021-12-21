""" Custom pretty-printer for scripts """
import os
import re
import subprocess
import colored


class PrettyPrinter():
    """ Custom pretty-printer for scripts """
    darkblue = colored.fg(238)
    darkwhite = colored.fg(7)
    almostgray = colored.fg(243)
    nicecyan = colored.fg(24)
    default = colored.fg(0)

    @classmethod
    def fg(cls, color: int):
        """ Print fg esc-seq """
        return colored.fg(color)

    @classmethod
    def _wrap(cls, out):
        """ generic string wrapper """
        return cls.darkblue + "⟮" + cls.darkwhite + out + cls.darkblue + "⟯"

    @classmethod
    def wrap(cls, text, delim='', postfix=''):
        """ Fancy wrapper """
        if delim:
            delim = cls.nicecyan + delim
        if postfix:
            postfix = cls.almostgray + postfix
        return cls._wrap(text + delim + postfix)

    @classmethod
    def size(cls, size, unit=None, pref='', wrap=True):
        """ Print file size """
        def nop(out):
            return out

        if pref is None:
            pref = ''
        elif not pref:
            pref = "sz"

        if pref:
            pref = pref + cls.almostgray + ":"

        if wrap:
            do_wrap = cls.wrap
        else:
            do_wrap = nop

        if unit is None:
            return do_wrap(
                cls.darkwhite + pref + cls.darkwhite + str(size)
            )

        return do_wrap(
            cls.darkwhite + pref + cls.darkwhite +
            str(size) + cls.almostgray + unit
        )

    @classmethod
    def filelen(cls, length):
        """ Print file line-length """
        return cls.wrap(
            cls.darkwhite + "len" + cls.almostgray + "=" +
            cls.darkwhite + str(length)
        )

    @classmethod
    def newfile(cls, filename):
        """ Print the new file """
        return cls.wrap(filename)

    @classmethod
    def dir(cls, filename):
        """ Print directory """
        return cls.wrap(filename)

    @classmethod
    def prefix(cls):
        """ Print prefix """
        return cls.wrap(colored.fg(25) + "❯" + colored.fg(26) + ">")

    @classmethod
    def delim(cls):
        """ Print delimiter """
        return cls.nicecyan + cls.default

    @classmethod
    def fancy_file(cls, filename):
        """ Pretty printing for filename """
        filename = re.sub('~', colored.fg(2) + "~" + colored.fg(7), filename)
        filename = re.sub(os.environ["HOME"], colored.fg(2) + "~" + colored.fg(7), filename)
        filename = re.sub("([/·])", colored.fg(4) + r"\1" + colored.fg(7), filename)
        filename = re.sub(
            r"(-\[)([0-9]+)(x)([0-9A-Z]+)(\]-)",
            colored.fg(4) + r"\1" + colored.fg(7) + r"\2" + \
            colored.fg(6) + r"\3" + \
            colored.fg(7) + r"\4" + colored.fg(4) + r"\5" + colored.fg(7),
            filename
        )
        return cls.wrap(filename)


# file info printer
class FileInfoPrinter():
    """ Prints info about files """
    def __init__(self):
        pass

    # counting with external wc is faster than everything else
    @staticmethod
    def wccount(filename):
        """ Print file line-length """
        out = subprocess.Popen(
            ['wc', '-l', filename],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL
        ).communicate()[0]

        return int(out.partition(b' ')[0])

    @staticmethod
    def nonexistsfile(filename):
        """ Print info about non-existing file """
        print(
            PrettyPrinter.prefix() +
            PrettyPrinter.fancy_file(filename) +
            PrettyPrinter.delim() +
            PrettyPrinter.newfile(filename)
        )

    @staticmethod
    def existsfile(filename):
        """ Print info about existing file """
        print(
            PrettyPrinter.prefix() +
            PrettyPrinter.fancy_file(filename) +
            PrettyPrinter.delim() +
            PrettyPrinter.size(os.stat(filename).st_size) +
            PrettyPrinter.delim() +
            PrettyPrinter.filelen(FileInfoPrinter.wccount(filename))
        )

    @staticmethod
    def currentdir(filename):
        """ Current directory printer """
        print(
            PrettyPrinter.prefix() +
            PrettyPrinter.wrap("current dir") +
            PrettyPrinter.delim() +
            PrettyPrinter.dir(filename)
        )

    @staticmethod
    def dir(filename):
        """ Directory printer """
        print(
            PrettyPrinter.prefix() +
            PrettyPrinter.fancy_file(filename) +
            PrettyPrinter.delim() +
            PrettyPrinter.dir(filename)
        )
