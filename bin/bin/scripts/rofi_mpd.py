#!/usr/bin/python3
# fork of github.com/tonooo71/rofi-mpd-client

import subprocess
import sys
from threading import Thread
import time
import musicpd


class rofi_options:
    def __init__(self, client):
        self.client = client
        self.mesg = ''
        self.options = [
            'rofi', '-levenshtein-sort', '-mesg', '', '', '-dmenu', '-p', '~/music/',
            '-font',    'Monospace Bold 12',
            '-width',   '60',
            '-padding', '10',
            '-lines',   '8',
            '-columns', '2',
        ]

    def gen_options(self):
        self.mesg = ''
        if self.client.status()['state'] != 'stop' \
                and self.client.playlistinfo():
            self.set_mesg()
        # self.options[4] = self.mesg
        # if self.client.playlistinfo():
        #     if self.client.status()['state'] != 'stop':
        #         pos = int(self.client.status()['song'])+1
        #         end = self.client.status()['playlistlength']
        #         self.options[4] += f'  [{pos}/{end}]'
        #     else:
        #         end = self.client.status()['playlistlength']
        #         self.options[4] += f'  [Playlist: {end}]'
        # self.options[8] = f'~/music/{top_dir}'
        # self.options[9] = '-matching'
        # self.options[10] = 'fuzzy'

    def set_mesg(self):
        song_dic = self.client.currentsong()
        if self.client.status()['state'] == 'play':
            self.mesg += '  '
        elif self.client.status()['state'] == 'pause':
            self.mesg += '  '
        try:
            song = song_dic['title']
            artist = song_dic['artist']
            self.mesg += f'{song} - {artist}'
        except Exception:
            self.mesg += song_dic['file'].split('/')[-1]


class rofi_index:
    def __init__(self, client):
        self.client = client
        self.top_dir = ''
        self.prefix = ''  # for play/pause, back, add all
        self.indexes = ''  # music

    def gen_index(self, top_dir):
        self.top_dir = top_dir
        if self.client.status()['state'] == 'play':
            self.prefix = ' Pause\n'
            if not top_dir:
                self.prefix += ' Next\n'
        else:
            self.prefix = ' Play\n'
        self.indexes = ''
        self.set_prefix()
        self.set_indexes()

    def set_prefix(self):
        if self.top_dir:
            self.prefix += ' Go Back\n'
            self.prefix += ' Add all\n'
        else:
            self.prefix = ' Playlist mode\n' + self.prefix

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


class rofi_playlist:
    def __init__(self, client):
        self.client = client
        self.prefix = ''  # for back index, delete mode, pause, back
        self.indexes = ''  # playlist
        self.playlist = ''  # None: default, Title: detail

    def gen_index(self):
        self.set_prefix()
        self.set_indexes()

    def set_prefix(self):
        if not self.playlist:
            self.prefix = ' Go Back to Main menu\n'
            self.prefix += ' Clear Playlist\n'
        else:
            self.prefix = ' Go Back\n'
            self.prefix += ' Add this playlist\n'

    def set_indexes(self):
        if not self.playlist:
            self.indexes = 'Stored playlists----------\n'
            for i in self.client.listplaylists():
                self.indexes += f'  {i["playlist"]}\n'
            current_song = 'GORNG'  # tmp
            try:
                current_song = self.client.currentsong()["title"]
            except Exception:
                pass
            self.indexes += 'Playlist------------------\n'
            for i, j in enumerate(self.client.playlistinfo()):
                if current_song == j["title"]:
                    self.indexes += f'  {j["title"]} - {j["artist"]}\n'
                else:
                    self.indexes += f' {i+1} {j["title"]} - {j["artist"]}\n'
        else:
            self.indexes = f'Playlist: {self.playlist}\n'
            for i, j in enumerate(self.client.listplaylistinfo(self.playlist)):
                self.indexes += f' {i+1} {j["title"]}\n'

def check(client):
    while True:
        print(client.status())
        time.sleep(1)

def main():
    client = musicpd.MPDClient()
    client.timeout = 300
    client.idletimeout = 300
    client.connect('::1', 6600)
    option = rofi_options(client)
    index = rofi_index(client)
    current_dir = ''
    status =  1 # select row place
    Thread(target=check, daemon=True, args=(client,)).start()
    while 1:
        option.gen_options()
        rofi = subprocess.Popen(
            option.options, stdout=subprocess.PIPE, stdin=subprocess.PIPE
        )
        index.gen_index(current_dir)
        select = index.prefix + index.indexes
        tmp = rofi.communicate(
            select.encode())[0].decode().rstrip()
        status = 1
        if not tmp:
            break
        if tmp == ' Go Back':
            if '/' in current_dir:
                current_dir = current_dir[:current_dir.rfind('/')]
            else:
                current_dir = ''
        elif tmp == ' Add all':
            client.add(current_dir)
            if '/' in current_dir:
                current_dir = current_dir[:current_dir.rfind('/')]
            else:
                current_dir = ''
        # Go to Playlist mode
        elif tmp == ' Playlist mode':
            playlist = rofi_playlist(client)
            status = 3
            while 1:
                if playlist.playlist:
                    status = 1
                option.gen_options()
                option.options[8] = f'[Playlist mode]{playlist.playlist}'
                rofi = subprocess.Popen(
                    option.options,
                    stdout=subprocess.PIPE,
                    stdin=subprocess.PIPE
                )
                playlist.gen_index()
                select = playlist.prefix + playlist.indexes
                tmp = rofi.communicate(select.encode())[0].decode().rstrip()
                status = 3
                if not tmp:
                    sys.exit()
                else:
                    if tmp == ' Go Back to Main menu':
                        status = 1
                        break
                    if tmp == ' Clear Playlist':
                        client.clear()
                    elif tmp == ' Go Back':
                        playlist.playlist = ''
                    elif tmp == ' Add this playlist':
                        client.load(playlist.playlist)
                        playlist.playlist = ''
                        status = 0
                    elif '' in tmp:
                        playlist.playlist = tmp.split()[-1]
                    else:
                        pass
        elif tmp == ' Play':
            if not client.playlistinfo():
                pass
            else:
                client.play()
        elif tmp == ' Pause':
            client.pause()
        elif tmp == ' Next':
            client.next()
        elif '' in tmp:  # TODO: add functions
            status = 2
        else:
            status = 2
            if current_dir:
                current_dir += '/' + tmp[4:]
            else:
                current_dir = tmp[4:]


if __name__ == '__main__':
    main()
