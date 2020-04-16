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
            self.mesg += f'{song} - {artist}'
        except Exception:
            self.mesg += song_dic['file'].split('/')[-1]

        self.options = [
            'rofi', '-levenshtein-sort', '-mesg', self.mesg, '',
            '-dmenu', '-p', '~/music/',
            '-font',    'Iosevka Term 12',
            '-width',   '60',
            '-padding', '10',
            '-lines',   '8',
            '-columns', '2',
        ]


class rofi_index:
    def __init__(self, client):
        self.client = client
        self.top_dir = ''
        self.indexes = ''

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
            elif 'title' in i:
                self.indexes += f'   {count}. {i["title"]}\n'
                count += 1
            elif 'file' in i:
                self.indexes += f'   {count}. {i["file"].split("/")[-1]}\n'
                count += 1


def check(client):
    while True:
        print(client.status())
        time.sleep(1)

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
            option.options, stdout=subprocess.PIPE, stdin=subprocess.PIPE
        )
        index.gen_index(current_dir)
        select = index.indexes
        tmp = rofi.communicate(
            select.encode())[0].decode().rstrip()
        if not tmp:
            break

        if tmp == ' Add all':
            client.add(current_dir)
            if '/' in current_dir:
                current_dir = current_dir[:current_dir.rfind('/')]
            else:
                current_dir = ''
        else:
            if current_dir:
                current_dir += '/' + tmp[4:]
            else:
                current_dir = tmp[4:]


if __name__ == '__main__':
    main()
