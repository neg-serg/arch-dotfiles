#!/usr/bin/env python3

import re
import subprocess

class ns_settings(object):
    def init_i3_win_cmds(self, hide=True, dprefix_="for_window "):
        def ch_(list, ch):
            if len(list) > 1:
                ret=ch
            else:
                ret=''
            return ret

        def parse_attr_(attr):
            ret=""
            attrib_list=self.settings[tag][attr]
            if len(attrib_list)>1:
                ret+='('
            for iter,item in zip(range(len(attrib_list)),attrib_list):
                if iter+1 < len(attrib_list):
                    ret+=item+'|'
                else:
                    ret+=item
            if len(attrib_list) > 1:
                ret+=')$'
            ret+='"] '

            return ret

        def mv_scratch():
            return "move scratchpad, "

        def hide_cmd():
            if hide:
                ret = ", [con_id=__focused__] scratchpad show"
            else:
                ret = ""
            return ret

        def ret_info(key):
            if key in attr:
                lst=[item for item in self.settings[tag][key] if item != '']
                if lst != []:
                    pref=dprefix_+"[" + '{}="'.format(attr) + ch_(self.settings[tag][attr],'^')
                    for_win_cmd=pref + parse_attr_(key) + mv_scratch() + self.get_geom(tag) + hide_cmd()
                    return for_win_cmd
            return ''

        cmd_list=[]
        for tag in self.settings:
            for attr in self.settings[tag]:
                cmd_list.append(ret_info('class'))
                cmd_list.append(ret_info('instance'))

        self.cmd_list=filter(lambda str: str!='', cmd_list)

    def get_geom(self, tag):
        return self.parsed_geom[tag]

    def __get_screen_resolution(self):
        output = subprocess.Popen('xrandr | awk \'/*/{print $1}\'',shell=True, stdout=subprocess.PIPE).communicate()[0]
        resolution = output.split()[0].split(b'x')
        return {'width': int(resolution[0]), 'height': int(resolution[1])}

    def __parse_geom(self, group):

        resolution_default={'width':1920, 'height':1200}

        geom=re.split(r'[x+]', self.settings[group]["geom"])
        converted_geom=[]

        converted_geom.append(int(int(geom[0])*self.current_resolution['width'] / resolution_default['width']))
        converted_geom.append(int(int(geom[1])*self.current_resolution['height'] / resolution_default['height']))
        converted_geom.append(int(int(geom[2])*self.current_resolution['width'] / resolution_default['width']))
        converted_geom.append(int(int(geom[3])*self.current_resolution['height'] / resolution_default['height']))

        return "move absolute position {2} {3}, resize set {0} {1}".format(*converted_geom)

    def __init__(self):
        self.settings = {
            'im' : {
                'class' : {
                    'TelegramDesktop',
                    'Telegram-desktop',
                    'telegram-desktop',
                    'skypeforlinux',
                    'Skype Preview',
                    'ViberPC',
                    'finch',
                    'VK',
                },
                'geom' : "528x1029+1372+127",
                'prog_dict': {
                    "tel" : {
                        "prog": "telegram-desktop",
                        "includes": {
                            'TelegramDesktop',
                            'Telegram-desktop',
                            'telegram-desktop'
                        },
                    },
                    "skype" : {
                        "prog": "skypeforlinux",
                        "includes": {
                            'skypeforlinux',
                            'Skype Preview'
                        },
                    }
                }
            },
            'ncmpcpp': {
                'class' : { 'mpd-pad2' },
                'geom' : "1200x600+400+400",
                'prog': 'st -f "PragmataPro for Powerline:pixelsize=18" -c mpd-pad2 -e ncmpcpp'
            },
            'ncmpcpp_fun': {
                'class' : { 'cool-retro-term' },
                'geom' : "1200x600+400+400",
                'prog': 'cool-retro-term --program ncmpcpp'
            },
            'weechat': {
                'class' : { '_weechat_' },
                'geom' : "1736x1091+112+33",
                'prog': 'st -c _weechat_ -f \'Terminus Re33:size=14:style=Bold\' zsh -c \'tmux -S ~/1st_level/weechat.socket new weechat\''
            },
            'mutt': {
                'instance' : { 'mutt' },
                'geom' : "1250x700+293+0",
                'prog' : "st -f \'PragmataPro for Powerline:size=12\' -c mutt -e mutt",
            },
            'ranger': {
                'class' : { 'ranger' },
                'geom' : "1132x760+170+18",
                'prog' : "~/bin/scripts/run_ranger"
            },
            'teardrop': {
                'class' : { 'teardrop' },
                'geom' : "1844x704+39+4",
                'prog' : "st -c teardrop -f \'PragmataPro for Powerline:size=18\' -e ~/bin/scripts/teardrop"
            },
            'console': {
                'class' : { 'youtube-get' },
                'geom': "1339x866+247+13",
                'prog' : "/bin/true",
            }
        }

        self.cmd_list=[]
        self.parsed_geom={}
        self.current_resolution=self.__get_screen_resolution()
        for tag in self.settings:
            self.parsed_geom[tag] = self.__parse_geom(tag)

if __name__ == "__main__":
    def print_info():
        conf=ns_settings()
        conf.init_i3_win_cmds()
        for ns_info in conf.cmd_list:
            print(ns_info)

    print_info()
