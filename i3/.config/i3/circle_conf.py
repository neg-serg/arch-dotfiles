#!/usr/bin/env python3
class cycle_settings(object):
    settings={}

    def __init__(self):
        self.settings = {
            'web' : {
                'classes' : {
                    'Firefox',
                    'Waterfox',
                    'Tor Browser',
                    'Chromium',
                    'Vivaldi-stable',
                    'Yandex-browser-beta',
                    'Luakit',
                    'Conkeror',
                    'Qutebrowser'
                },
                'prog':"waterfox",
                'priority':'Waterfox',
            },
            'vid':{
                'classes': {
                    'mpv',
                    'mplayer',
                    'mplayer2',
                    'Vlc'
                },
            },
            'steam':{
                'classes': {
                    'Wine',
                    'dota2',
                    'darkest.bin.x86_64',
                    'Steam',
                    'steam',
                    'explorer.exe',
                },
                'prog':"steam",
            },
            'doc':{
                'classes': {
                    'Zathura',
                },
            },
            'vm':{
                'classes': {
                    'VirtualBox',
                    'vmware',
                    'qemu-system-x86_64',
                    "Qemu-system-x86_64",
                },
            },
            'term':{
                'classes': { 'MainTerminal' },
                'instances': { 'MainTerminal' },
                'prog':"~/bin/term",
            },
            'nwim':{
                'classes': { 'nwim', 'wim' },
                'instances': { 'nwim', 'wim' },
                'prog':"~/bin/nwim",
            },
            'emacs':{
                'classes': { 'Emacs' },
                'prog':"emacs",
            },
            'jetbrains-idea':{
                'classes': {
                    'jetbrains-idea',
                    'clion',
                    'andrond-studio',
                },
                'prog':"~/bin/scripts/jetbrains.sh idea",
            },
            'jetbrains-clion':{
                'class_r': {
                    '^jetbrains-jetbrains-idea.*',
                    '^jetbrains-clion.*',
                    '^jetbrains-andrond-studio.*',
                    "sun-awt-X11-XFramePeer"
                },
                'prog':"~/bin/scripts/jetbrains.sh clion",
            },
        }
