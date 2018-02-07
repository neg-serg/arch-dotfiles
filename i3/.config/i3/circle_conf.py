class cycle_settings(object):
    settings={}

    def __init__(self):
        self.settings = {
            'web' : {
                'class' : {
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
                'prog': "waterfox",
                'prog_dict': {
                    "main" : {
                        "prog": "waterfox",
                        "includes": {'Firefox', 'Waterfox'},
                    },
                    "tor" : {
                        "prog": "tor-browser-en",
                        "includes": {'Tor Browser'},
                    },
                    "yandex" : {
                        "prog": "yandex-browser-beta",
                        "includes": {'Yandex-browser-beta'},
                    },
                },
                'priority':'Waterfox',
            },
            'vid':{
                'class': {
                    'mpv',
                    'mplayer',
                    'mplayer2',
                    'Vlc'
                },
            },
            'steam':{
                'class_r': {
                    '^Wine$',
                    '^dota2$',
                    '^darkest.bin.x86_64$',
                    '^[sS]team$',
                    '.*.exe$',
                },
                'prog':"steam",
            },
            'doc':{
                'class': { 'Zathura', },
            },
            'vm':{
                'class_r': { 'VirtualBox', 'vmware', '[Qq]emu-.*', },
            },
            'term':{
                'class': { 'MainTerminal' },
                'instance': { 'MainTerminal' },
                'prog':"~/bin/term",
            },
            'nwim':{
                'class': { 'nwim', 'wim' },
                'instance': { 'nwim', 'wim' },
                'prog':"~/bin/nwim",
            },
            'emacs':{
                'class': { 'Emacs' },
                'prog':"emacs",
            },
            'jetbrains-idea':{
                'class': { 'jetbrains-idea', 'clion', 'andrond-studio', },
                'prog':"~/bin/scripts/jetbrains.sh idea",
            },
            'jetbrains-clion': {
                'class_r': {
                    '^jetbrains-jetbrains-idea.*',
                    '^jetbrains-clion.*',
                    '^jetbrains-andrond-studio.*',
                    "sun-awt-X11-XFramePeer"
                },
                'prog':"~/bin/scripts/jetbrains.sh clion",
            },
            'sxiv': {
                'class': {
                    'Sxiv',
                },
                'prog':"st zsh -c 'find ~/dw/ ~/tmp/shots/ -maxdepth 1 -type d -print0 |xargs -0 ~/bin/sx' &",
            },
        }
