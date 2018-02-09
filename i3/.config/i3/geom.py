import re
import subprocess

class geom():
    def __init__(self, settings):
        self.cmd_list=[]
        self.parsed_geom={}
        self.current_resolution=self.__get_screen_resolution()
        self.settings=settings
        for tag in self.settings:
            self.parsed_geom[tag] = self.__parse_geom(tag)

    def init_i3_win_cmds(self, hide=True, dprefix_="for_window "):
        def ch_(list, ch):
            ret=''
            if len(list) > 1:
                ret=ch
            return ret

        def parse_attr_(attr):
            ret=""
            attrib_list=self.settings[tag][attr]
            if len(attrib_list)>1:
                ret+='('
            for iter,item in enumerate(attrib_list):
                ret+=item
                if iter+1 < len(attrib_list):
                    ret+='|'
            if len(attrib_list) > 1:
                ret+=')$'
            ret+='"] '

            return ret

        def hide_cmd():
            ret = ""
            if hide:
                ret = ", [con_id=__focused__] scratchpad show"
            return ret

        def ret_info(key):
            if key in attr:
                lst=[item for item in self.settings[tag][key] if item != '']
                if lst != []:
                    pref=dprefix_+"[" + '{}="'.format(attr) + ch_(self.settings[tag][attr],'^')
                    for_win_cmd=pref + parse_attr_(key) + "move scratchpad, " + self.get_geom(tag) + hide_cmd()
                    return for_win_cmd
            return ''

        cmd_list=[]
        for tag in self.settings:
            for attr in self.settings[tag]:
                cmd_list.append(ret_info('class'))
                cmd_list.append(ret_info('instance'))

        self.cmd_list=filter(lambda str: str!='', cmd_list)

    # nsd need this function
    def get_geom(self, tag):
        return self.parsed_geom[tag]

    def __get_screen_resolution(self):
        output = subprocess.Popen('xrandr | awk \'/*/{print $1}\'',shell=True, stdout=subprocess.PIPE).communicate()[0]
        resolution = output.split()[0].split(b'x')
        return {'width': int(resolution[0]), 'height': int(resolution[1])}

    def __parse_geom(self, group):
        rd={'width':1920, 'height':1200} # resolution_default
        cr=self.current_resolution       # current resolution

        g=re.split(r'[x+]', self.settings[group]["geom"])
        cg=[] # converted_geom

        cg.append(int(int(g[0])*cr['width']  / rd['width']))
        cg.append(int(int(g[1])*cr['height'] / rd['height']))
        cg.append(int(int(g[2])*cr['width']  / rd['width']))
        cg.append(int(int(g[3])*cr['height'] / rd['height']))

        return "move absolute position {2} {3}, resize set {0} {1}".format(*cg)
