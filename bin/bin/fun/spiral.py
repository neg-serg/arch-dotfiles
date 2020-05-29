#!/usr/bin/env python
 
import os, sys, random, time
 
 
def slt(img):
    return img.split("\n")
 
def get_scr_size():
    return [int(x) for x in os.popen("stty size", "r").read().split()]
 
def get_img_size(img):
    return [IMG.count("\n"), max([len(x) for x in slt(IMG)])]
 
def init():
    global scr, img
    os.system("tput civis -- invisible")
    os.system("clear")
    scr = get_scr_size()
    img = get_img_size(IMG)
 
colors = [
    [37, 31, 33, 34, 35, 36, 32],
    [31, 33, 34, 35, 36, 37, 30]
]
 
def get_color(x, y, t):
    global colors, img
 
    f = x -max(img) +abs(t)
 
    off = random.randint(0, 16)
 
    for i in range(6, -1, -1):
        if f > y +(i *16) +off:
            if t >= 0:
                return "\033[" +str(colors[1][i]) +"m"
            elif t < 0:
                return "\033[" +str(colors[0][i]) +"m"
    return t <= 0 and "\033[30m" or "\033[" +str(colors[0][-1]) +"m"
 
 
 
 
 
 
IMG = ["""
                 `,:;'''++''';:,`
             ,'++++############++++',
          :'++######################++':
       `'++########++';::;;;''++++#####++'`
      '+########++;`            .:'++#####+'
    :++#######+'`                   ,++####++:
   ;+#######+'`         .,,,.`        ;+#####+;
  '+#####+'''       ,'+++++++++'`      ,+#####+'
 ;+######+';     `'++##++''''++++:      '+#####+;
,+######+';     ;+###++,      .'++:    ,++######+,
'+######++.    ;+###+'    :''''+++'    ,++######+'
.++######+'    ,+###+'   :++####+';'    `++######++.
:+#######+'    ;+###+;   '+#####+++'    ;++#######+:
:+#######+'    ;+###+;   :++++++'''`   ,++########+:
,+#######+'    :+###++.   .'',`;':    ,+##########+,
.++######++.   .++##++,`     `       '+##########++.
'+#######+;     '+####+'         :'+############+'
,++######++,    `'+#####+++'''+++##############++,
 :+#######++.    :+############################+:
  ;+#######++.    ,++#########################+;
   :+########+;     ;++######################+:
    .'+#######++,     :'++#################+'.
      :++#######++;      :'+#############++:
        :++########++':`  :++##########++:
          .;+++########+++#########+++;.
              :'+++++########+++++':
                   .,:;;;;;;:,.
""",
"""
                       ..
                       dd`
                      sMMy
                     /MMMMo
                    -NMMMMM/
                   `mMMMMMMN-
                  `dMMMMMMMMN.
                  yMMMMMMMMMMm`
                 `-hMMMMMMMMMMd`
                oMh+/hMMMMMMMMMh`
               +MMMMMdymMMMMMMMMh
              +MMMMMMMMMMMMMMMMMMy
             +MMMMMMMMMMMMMMMMMMMMy
            +MMMMMMMMMMMMMMMMMMMMMMy
           +MMMMMMMMMMMMMMMMMMMMMMMMy
          +MMMMMMMMMMMmhhmMMMMMMMMMMMy
         oMMMMMMMMMMh-    .yMMMMMMMMMMy
        oMMMMMMMMMMs        +MMMMMMMMMMh
       sMMMMMMMMMMm          hMMMMMMMMMMh`
      sMMMMMMMMMMMo          :MMMMMMNddNMh`
     yMMMMMMMMMMMM/          .MMMMMMMMNs///
    yMMMMMMMMMMMMMo          :MMMMMMMMMMMmo`
  `hMMMMMMMMMNhs+:.          `:+shNMMMMMMMMNy`
 `hMMMMMNho:`                      `:ohNMMMMMd`
`dMMNh+-                                -+hNMMm.
`mdo:                                        :odm.
:.                                              .:
""",
"""
                                        . `
                                       :+/-
                                      /yy:/oo.   .::::-.
                     `N/`-           `hMMo:   .yNMMMMMMMNy`
                      -d:o//        `dd.     /MMMMMMMMMMMM-
                       `yy+./+      .hdhs/.-yMMMMMMMMMMMd-
                    oh//NMo.`     .:+osyMMMMMMMMMMMMMMd/
                        so    .ohNMMMMMMMMMMMNooyddho-
                        m.  .hMMMMMMMMMMMMdmM-
                        Nh+yMMMMMMmdddmds- oN
                        NMMMMMMMy`         +Ns.`/y/-
                      .yMMMMMMMM/           `:smd++o+
                    :hMMMMMNdhydm/   :+        `o//`
                  :dMMMMmy/`    `omyhh+os`        ::
                `yMMMNs-          .msy:.
                hMMm+`            .h y.+s`
               +MMy`             /d: om-`
               mMh                   `oh
              -MM.
              +MN
              sMd
              dMs
             -MN.
            .mN:
          `oNh.
        -sNd:
    `:sdho.
`:+oo/.
`-`
""",
"""
                      `.
                      ,:`
                      :;`
                     ,;;:`
                    `:;';.
   `,`              `;'';.              `,`
    ,;,`            ,;''':            `,;,
     ,;;,.          ,;'';:`         .,;;:
     .;'';,`        ,;''':`       `,;'';.
     `:;''';.      `:'''';.      .:''';:`
      `;'''';,`    `:;''';`    `.;'''';.
       `:'''';:`    :'''';`   `:;'''';.
        `:;''';;.   :;''';.  `:;'''';.
         .:;'''':.  .;''':` `:;'''';.
          `:;'''':` `;'';, `:;'''';.
`.````      `,;''';,`.;'';,`,;''';:`      ````.`
.:;;;;:,,``  `:;''',`,'';`.;'';;.  ``,,:;;;;:.
  .:;'''';;:,``,;'';,,;':.;'';:.`,:;;'''';:.
    .:;;''''';;,.:;';,;'::';;,,:;''''';;,`
      `.::;;'''';:,;';;;;';::;'''';;:,`
          `.,::;;;;;;;;;;;;;;;;:,.`
                `.,;;;'';;;,.`
             `.,:;'''';;;''';;:.`
           .:;;''''';,.:.;'''''';;,`
        `.:;;';;;;:,` .: `.::;;;;;;;,`
       `......``      .:       `````..`
                      ,:
                      ,:
                      ,,
"""]
 
 
 
 
 
 
 
try: IMG = IMG[int(sys.argv[1])]
except: IMG = IMG[0]
 
init()
 
frames = img[0] *6
step = 6
 
while 1:
    for t in (list(range(-frames, step, step)) +list(range(frames, 0, -step))):
        print("\033[" +str(int((scr[0] -img[0]) /2)) +"H")
 
        for y in range(img[0]):
            print((" " *int((scr[1] -img[1])/ 2)) +"".join([(get_color(x, y, t) +slt(IMG)[y][x] +"\033[0m") for x in range(len(slt(IMG)[y]))]))
 
        if t == 0:
            colors[0].append(colors[0].pop(random.randint(1, 3)))
            init()
            time.sleep(.3)
            break
 
        time.sleep(.04)
    time.sleep(1)
    os.system("tput cvvis")
    break
