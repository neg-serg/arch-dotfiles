#!/usr/bin/python3
# fork of github.com/tonooo71/rofi-mpd-client

import subprocess
from threading import Thread
import time
import musicpd


class rofi_options:
    def __init__(self, client):
        self.client = client
        self.mesg = ''
        self.options = []

    def set_mesg(self):
        song_dic = self.client.currentsong()
        try:
            song = song_dic['title']
            artist = song_dic['artist']
            self.mesg = f'{song} - {artist}'
        except Exception:
            file = song_dic.get('file', '')
            if file:
                self.mesg += song_dic['file'].split('/')[-1]

        self.options = [
            'rofi', '-i',
            '-sort',
            '-mesg', self.mesg, '-auto-select',
            '-dmenu', '-p', '~/music/',
            '-matching', 'fuzzy',
            '-lines',   '8',
            '-columns', '2',

            '-theme-str', '* { font: "Iosevka Term Bold 24"; }',
            '-theme-str', '#window { width:2400; y-offset: -64;'
            'location: south west; anchor: south west; }',
        ]


class rofi_index:
    def __init__(self, client):
        self.client = client
        self.top_dir = ''
        self.indexes = ''
        self.show_files = False

    def gen_index(self, top_dir):
        self.top_dir = top_dir
        self.indexes = ''
        self.set_indexes()

    def set_indexes(self):
        indexes_dic = self.client.lsinfo(self.top_dir)
        count = 1
        for i in indexes_dic:
            if 'directory' in i:
                self.indexes += f'   {i["directory"].split("/")[-1]}\n'

            if self.show_files:
                if 'title' in i:
                    self.indexes += f'   {count}. {i["title"]}\n'
                    count += 1
                elif 'file' in i:
                    self.indexes += f'   {count}. {i["file"].split("/")[-1]}\n'
                    count += 1


def check(client):
    while True:
        client.status()
        time.sleep(2)

def main():
    client = musicpd.MPDClient()
    client.timeout = 30
    client.idletimeout = 30
    client.connect('::1', 6600)
    option = rofi_options(client)
    index = rofi_index(client)
    current_dir = ''
    Thread(target=check, daemon=True, args=(client,)).start()

    while 1:
        option.set_mesg()
        rofi = subprocess.Popen(
            option.options,
            stdout=subprocess.PIPE,
            stdin=subprocess.PIPE
        )
        index.gen_index(current_dir)
        select = index.indexes
        rofi_input = rofi.communicate(
            select.encode()
        )[0].decode().rstrip()
        if rofi_input.startswith('..'):
            if '/' in current_dir:
                current_dir = current_dir[:current_dir.rfind('/')]
            else:
                current_dir = ''
            continue
        if not rofi_input:
            if current_dir and current_dir != 'new':
                client.clear()
                client.add(current_dir)
                client.play()
                if '/' in current_dir:
                    current_dir = current_dir[:current_dir.rfind('/')]
                else:
                    current_dir = ''
            break

        if current_dir:
            current_dir += '/' + rofi_input[4:]
        else:
            current_dir = rofi_input[4:]


if __name__ == '__main__':
    main()
