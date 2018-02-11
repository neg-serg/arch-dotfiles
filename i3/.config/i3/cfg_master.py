import os
import sys
import toml

class CfgMaster():
    def reload_config(self):
        mod=self.__class__.__name__
        prev_conf=self.cfg
        try:
            self.load_config(mod)
            self.__init__()
            print("config_reloaded")
        except:
            print("config reload failed")
            self.cfg=prev_conf
            self.__init__()

    def dict_converse(self):
        for i in self.cfg:
            for j in self.cfg[i]:
                if j in {"class", "class_r", "instance"}:
                    self.cfg[i][j]=set(self.cfg[i][sys.intern(j)])
                if j == "prog_dict":
                    for k in self.cfg[i][j]:
                        for kk in self.cfg[i][j][k]:
                            if kk == "includes":
                                self.cfg[i][j][k][kk]=set(self.cfg[i][j][k][sys.intern(kk)])

    def load_config(self, mod):
        user_name=os.environ.get("USER", "neg")
        xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")
        self.i3_path=xdg_config_path+"/i3/"
        with open(self.i3_path + mod + ".cfg", "r") as fp:
            self.cfg=toml.load(fp)
        self.dict_converse()

