[ -f "$HOME/.profile" ] && source "$HOME/.profile"
# Make sure the terminal type we're using is supported (tmux-256color doesn't
# work everywhere yet)
if ! infocmp "$TERM" > /dev/null 2>&1; then
    if [[ "$TERM" = "tmux-256color" ]]; then
        export TERM="screen-256color"
    else
        export TERM="xterm-256color"
    fi
fi

shopt -qs autocd # cd without typing cd
shopt -qs cdspell # Auto-correct directory typos
shopt -qs checkhash # Check hash before executing
shopt -s checkwinsize # Check window size after each command, and update $LINES and $COLUMNS
shopt -s cmdhist # Save all lines of multiline commands
shopt -qs direxpand # Expand directory names when doing file completion
shopt -qs dirspell # Fix typos for directories in completion
shopt -qs dotglob # Include filenames that begin with '.' in filename expansion
shopt -qs extglob # Extended pattern matching
shopt -qs extquote # Allow escape sequencing within ${parameter} expansions
shopt -qs globstar # Support ** for expansion
shopt -qs histappend histreedit histverify
shopt -qs hostcomplete
shopt -s nocaseglob nocasematch

alias :q="exit"
alias dd='dd status=progress'
alias k=kubectl
alias l='ls'
alias ll='ls -lah'
alias ls='ls --time-style=+"%d.%m.%Y %H:%M" --color=auto --hyperlink=auto'
alias mk='mkdir -p'
alias mv='mv -i'
alias rd='rmdir'
alias sort='sort --parallel 8 -S 16M'
alias v='vim'

if >/dev/null command -v git; then
    alias gd='git diff -w -U0 --word-diff-regex=[^[:space:]]'
    alias gp='git push'
    alias gs='git status --short -b'
    alias add="git add"
    alias checkout='git checkout'
    alias fetch="git fetch"
    alias pull="git pull"
    alias push='git push'
    alias stash="git stash"
    alias status="git status"
    alias commit='git commit'
fi

any(){
    [ -n "$1" ] && ps uwwwp $(pgrep -f "$@") 
}

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
export LANG=en_US.UTF-8
PS1="\u@$(tput setaf 2)\h$(tput sgr0) \w $(tput setaf 25)❯>$(tput sgr0) "                                                                    
export PS1
export LS_COLORS='no=00:fi=00:rs=00:di=07;38;5;234;48;5;25:so=01;38;5;075:bd=38;5;24:cd=38;5;24;1:ca=38;5;17:no=00:ex=04;03:pi=38;5;126:do=38;5;127:ln=03;38;5;05:or=01;03;38;5;196;48;5;52:mh=48;5;233;38;5;7;1;3:ow=48;5;233;38;5;7;1;3:sg=38;5;37;1:su=38;5;37:st=38;5;86;48;5;234:tw=38;5;86;48;5;234;1:*.bin=00;38;5;249:*.btm=00;38;5;111:*.com=00;38;5;111:*.exe=00;38;5;111:*.bat=00;38;5;31:*.cmd=00;38;5;31:*.7z=01;38;5;61:*.ace=01;38;5;61:*.alp=01;38;5;61:*.alz=01;38;5;61:*.arc=00;38;5;61:*.arj=00;38;5;61:*.bz=01;38;5;61:*.bz2=01;38;5;61:*.cpio=01;38;5;61:*.dz=01;38;5;61:*.gz=01;38;5;61:*.klwp=00;38;5;61:*.lha=01;38;5;61:*.lrz=01;38;5;61:*.lz=01;38;5;61:*.lz4=01;38;5;61:*.lzh=01;38;5;61:*.lzma=01;38;5;61:*.rar=00;38;5;63:*.rz=01;38;5;61:*.t7z=01;38;5;61:*.tar=00;38;5;61:*.taz=01;38;5;61:*.tbz=01;38;5;61:*.tbz2=01;38;5;61:*.tgz=01;38;5;61:*.tlz=01;38;5;61:*.txz=01;38;5;61:*.tz=01;38;5;61:*.tzo=01;38;5;61:*.xz=01;38;5;61:*.z=01;38;5;61:*.Z=01;38;5;61:*.zip=01;38;5;61:*.ZIP=01;38;5;61:*.zoo=01;38;5;61:*.apk=00;38;5;74:*.arj=00;38;5;73:*.cab=00;38;5;74:*.deb=00;38;5;74:*.ear=00;38;5;73:*.egg=00;38;5;74:*.gem=00;38;5;74:*.jad=00;38;5;74:*.jar=00;38;5;73:*.msi=00;38;5;74:*.pkg=00;38;5;74:*.rpm=00;38;5;74:*.sar=00;38;5;73:*.udeb=00;38;5;74:*.war=00;38;5;73:*.xpi=00;38;5;74:*.qcow=00;38;5;61:*.qcow2=00;38;5;61:*.vdi=00;38;5;61:*.vmdk=00;38;5;61:*.jpeg=00;38;5;24:*.jpg=00;38;5;24:*.JPG=00;38;5;24:*.bmp=01;38;5;110:*.indd=00;38;5;110:*.pbm=00;38;5;110:*.pgm=00;38;5;110:*.ppm=00;38;5;110:*.psd=00;38;5;110:*.tga=00;38;5;110:*.xbm=00;38;5;111:*.tif=00;38;5;33:*.tiff=00;38;5;33:*.xpm=00;38;5;36:*.bpg=01;38;5;24:*.cgm=01;38;5;24:*.CR2=01;38;5;24:*.dl=00;38;5;24:*.emf=01;38;5;24:*.eps=01;38;5;24:*.mng=00;38;5;24:*.pcx=00;38;5;24:*.png=01;38;5;24:*.svg=00;38;5;25:*.svgz=00;38;5;25:*.webp=01;38;5;24:*.xcf=01;38;5;24:*.xwd=01;38;5;24:*.yuv=01;38;5;24:*.icc=00;38;5;249:*.icm=00;38;5;249:*.gif=01;38;5;25:*.icns=01;38;5;25:*.ico=01;38;5;25:*.key=01;38;5;53:*.pem=00;38;5;53:*.pub=00;38;5;53:*#=00;38;5;235:*~=01;38;5;235:*.added=00;38;5;235:*.aux=01;38;5;235:*.bak=01;38;5;235:*.bbl=01;38;5;235:*.bck=00;38;5;244:*.blg=01;38;5;235:*.cache=01;38;5;235:*.class=01;38;5;235:*.incomplete=01;38;5;235:*.log=01;38;5;235:*.o=01;38;5;235:*.part=01;38;5;235:*.pyc=01;38;5;235:*.swp=01;38;5;235:*.temp=00;38;5;244:*.tmp=00;38;5;244:*.cbz=01;38;5;7:*.chm=00;38;5;235:*.chrt=01;38;5;14:*.db=00;38;5;99:*.djv=00;38;5;7:*.djvu=00;38;5;7:*.doc=00;38;5;30:*.docm=00;38;5;30:*.docx=00;38;5;30:*.dot=00;38;5;30:*.dotm=00;38;5;30:*.dvi=00;38;5;235:*.epub=00;38;5;7:*.fb2=00;38;5;7:*.gnumeric=00;38;5;14:*.ldf=00;38;5;99:*.lit=00;38;5;7:*.markdown=00;38;5;110:*.md=00;38;5;110:*.mdb=00;38;5;99:*.mdf=00;38;5;99:*.mf=03;38;5;110:*.mfasl=00;38;5;73:*.mkd=00;38;5;110:*.mobi=00;38;5;7:*.odb=00;38;5;29:*.odb=00;38;5;99:*.odm=00;38;5;30:*.odp=00;38;5;29:*.ods=00;38;5;29:*.odt=00;38;5;30:*.org=00;38;5;110:*.pages=00;38;5;30:*.pdf=01;38;5;7:*.ppt=00;38;5;31:*.pptx=00;38;5;31:*.rtf=00;38;5;30:*.sql=00;38;5;99:*.sqlite=00;38;5;99:*.txt=00;38;5;60:*.xla=00;38;5;14:*.xls=00;38;5;14:*.xlsm=00;38;5;14:*.xlsx=00;38;5;14:*.agda=00;38;5;34:*.asm=00;38;5;64:*.asoundrc=00;38;5;36:*.awk=00;38;5;36:*.coffee=00;38;5;36:*.cs=00;38;5;36:*.css=00;38;5;31:*.csv=00;38;5;36:*.dir_colors=01;38;5;34:*.e=01;38;5;245:*.enc=00;38;5;36:*.eps2=00;38;5;7:*.eps3=00;38;5;7:*.eps=00;38;5;7:*.epsf=00;38;5;7:*.epsi=00;38;5;7:*.etx=00;38;5;36:*.ex=00;38;5;36:*.example=00;38;5;36:*.fehbg=00;38;5;36:*.fonts=00;38;5;36:*.git=00;38;5;36:*.gitignore=00;38;5;238:*.hgignore=01;38;5;23:*.hgrc=01;38;5;23:*.hs=00;38;5;34:*.htm=00;38;5;29:*.html=00;38;5;29:*.htoprc=01;38;5;23:*.info=01;38;5;23:*.java=01;04;38;5;245:*.jhtm=01;38;5;29:*.jnlp=04;38;5;245:*.js=01;04;38;5;34:*.jsm=00;38;5;74:*.jsp=00;38;5;74:*.lam=00;38;5;74:*.less=00;38;5;31:*.lesshst=01;38;5;23:*.lisp=00;38;5;74:*.log=01;38;5;23:*.lua=04;38;5;24:*.map=01;38;5;32:*.mf=01;38;5;32:*.mfasl=01;38;5;32:*.mi=01;38;5;32:*.msmtprc=01;38;5;32:*.mtx=01;38;5;32:*.mutt=00;38;5;36:*.muttrc=01;38;5;32:*.netrc=01;38;5;34:*.nfo=01;38;5;32:*.pacnew=00;38;5;33:*.ps=00;38;5;7:*.sass=00;38;5;31:*.scm=00;38;5;74:*.scss=00;38;5;31:*.diff=48;5;7;38;5;16;1:*.patch=48;5;7;38;5;16;1:*.attheme=00;38;5;35:*.colors=01;38;5;5:*.erb=01;38;5;33:*.irb=01;38;5;33:*.pc=00;38;5;4:*.pfa=00;38;5;4:*.php=00;38;5;4:*.pid=00;38;5;4:*.pl=00;38;5;73:*.PL=01;38;5;73:*.pm=00;38;5;4:*.pod=01;38;5;23:*.py=01;38;5;30:*.rasi=01;38;5;5:*.rb=01;04;38;5;33:*.ru=00;38;5;4:*.sed=00;38;5;4:*.signature=00;38;5;4:*.sty=01;38;5;5:*.sug=01;38;5;5:*.t=01;38;5;28:*.tcl=04;38;5;34:*.tdesktop-pallete=01;38;5;5:*.tdesktop-theme=01;38;5;5:*.tdy=01;38;5;5:*.tfm=01;38;5;5:*.tfnt=01;38;5;5:*.theme=01;38;5;5:*.tk=04;38;5;34:*.vim=00;38;5;56:*.viminfo=00;38;5;56:*.vimp=00;38;5;56:*.vimrc=04;38;5;56:*.bash=01;38;5;103:*.bash_history=01;38;5;103:*.bash_logout=01;38;5;29;4:*.bash_profile=01;38;5;29;4:*.csh=01;38;5;103:*.dash=01;38;5;103:*.fish=01;38;5;103:*.ksh=01;38;5;103:*.profile=01;38;5;29;4:*.sh=01;38;5;103:*.sh*=01;38;5;103:*.snippets=00;38;5;31:*.tcsh=01;38;5;103:*.ttytterrc=01;38;5;5:*.urlview=01;38;5;5:*.Xauthority=01;38;5;4:*.xinitrc=01;38;5;4:*.Xmodmap=00;38;5;4:*.Xresources=01;38;5;33:*.zsh=01;38;5;103:*.zwc=01;38;5;239:*.dmg=01;38;5;134:*.img=01;38;5;134:*.iso=01;38;5;134:*.ISO=01;38;5;134:*.mdf=01;38;5;134:*.nrg=01;38;5;134:*.vcd=01;38;5;134:*.allow=00;38;5;24:*.deny=00;38;5;89:*1=00;38;5;60:*.aux=00;38;5;239:*build.xml=00;38;5;60:*.cfg=00;38;5;29:*.conf=00;38;5;29:*config=00;38;5;29:*Dockerfile=00;38;5;60:*.icls=00;38;5;60:*.ini=00;38;5;29:*.jidgo=00;38;5;60:*.json=01;38;5;29:*.hjson=01;38;5;29:*.latex=01;04;38;5;73:*LICENSE=00;38;5;60:*Makefile=00;38;5;60:*.mk=00;38;5;60:*.modulemap=00;38;5;60:*.n3=00;38;5;60:*.nfo=00;38;5;60:*.nix=00;38;5;29:*.nt=00;38;5;60:*.ovpn=00;38;5;29:*.owl=00;38;5;60:*.qml=00;38;5;60:*Rakefile=00;38;5;60:*rc=00;38;5;60:*.rc=00;38;5;60:*.rdf=00;38;5;60:*README=00;38;5;60:*README.markdown=00;38;5;60:*README.md=00;38;5;60:*readme.txt=00;38;5;60:*README.txt=00;38;5;60:*.reg=00;38;5;29:*.sbt=00;38;5;60:*.sls=00;38;5;29:*.tex=01;04;38;5;73:*.textile=00;38;5;60:*TODO=01;38;5;91:*.toml=00;38;5;29:*.torrent=00;38;5;60:*.ttl=00;38;5;60:*.wiki=01;38;5;29:*.norg=01;38;5;29:*.xkb=03;38;5;29:*.xml=00;38;5;60:*.yaml=00;38;5;60:*.yml=00;38;5;29:*.a=01;38;5;22:*.dll=01;38;5;22:*.so=01;38;5;22:*.ffp=00;38;5;69:*.gpg=00;38;5;69:*.md5=00;38;5;69:*.par=00;38;5;69:*.sfv=00;38;5;69:*.sha1=00;38;5;69:*.st5=00;38;5;69:*.aac=03;38;5;37:*.aiff=01;03;38;5;37:*.alac=01;03;38;5;37:*.ape=01;03;38;5;37:*.au=03;38;5;37:*.axa=03;38;5;37:*.dff=01;03;38;5;37:*.dsf=01;03;38;5;37:*.flac=01;03;38;5;37:*.m4a=03;38;5;37:*.m4b=03;38;5;37:*.m4r=03;38;5;37:*.mid=03;38;5;37:*.midi=03;38;5;37:*.mka=03;38;5;37:*.mp2=03;38;5;37:*.mp3=03;38;5;37:*.mpc=03;38;5;37:*.oga=03;38;5;37:*.ogg=03;38;5;37:*.ra=03;38;5;37:*.spx=03;38;5;37:*.wav=03;38;5;37:*.wma=03;38;5;37:*.cue=04;03;38;5;28:*.m3u=04;03;38;5;28:*.m3u8=04;03;38;5;28:*.pls=04;03;38;5;28:*.xspf=04;03;38;5;28:*.dat=00;38;5;5:*.fcm=00;38;5;5:*.m4=03;38;5;5:*.mod=00;38;5;5:*.oga=00;38;5;5:*.s3m=01;38;5;5:*.S3M=01;38;5;5:*.sid=01;38;5;5:*.spl=00;38;5;5:*.wv=00;38;5;5:*.wvc=00;38;5;5:*.asf=01;38;5;75:*.avi=01;38;5;75:*.AVI=01;38;5;75:*.divx=01;38;5;75:*.flc=01;38;5;75:*.fli=01;38;5;75:*.flv=01;38;5;75:*.gl=01;38;5;75:*.m2ts=01;38;5;75:*.m2v=01;38;5;75:*.m4v=01;38;5;75:*.mjpeg=01;38;5;75:*.mkv=01;38;5;75:*.mov=01;38;5;75:*.MOV=01;38;5;75:*.mp4=01;38;5;75:*.mp4v=01;38;5;75:*.mpeg=01;38;5;75:*.mpg=01;38;5;75:*.nuv=01;38;5;75:*.ogm=01;38;5;75:*.ogv=01;38;5;75:*.qt=01;38;5;75:*.rm=01;38;5;75:*.rmvb=01;38;5;75:*.sample=01;38;5;75:*.ts=00;38;5;75:*.vob=01;38;5;75:*.VOB=01;38;5;75:*.webm=01;38;5;75:*.wmv=01;38;5;75:*.anx=01;38;5;13:*.ass=01;38;5;116:*.axv=01;38;5;13:*.ogx=01;38;5;13:*.srt=01;38;5;116:*.bdf=00;38;5;61:*.dfont=01;38;5;61:*.fon=01;38;5;61:*.gsf=00;38;5;61:*.otf=01;38;5;61:*.pcf=00;38;5;61:*.pfa=00;38;5;61:*.pfb=00;38;5;61:*.ttf=01;38;5;61:*.32x=00;38;5;232:*.a00=00;38;5;232:*.a52=00;38;5;232:*.a64=00;38;5;232:*.A64=00;38;5;232:*.a78=00;38;5;232:*.adf=00;38;5;35:*.atr=00;38;5;232:*.cdi=00;38;5;232:*.fm2=00;38;5;35:*.gb=00;38;5;232:*.gba=00;38;5;232:*.gbc=00;38;5;232:*.gel=00;38;5;232:*.gg=00;38;5;232:*.ggl=00;38;5;232:*.j64=00;38;5;232:*.nds=00;38;5;232:*.nes=00;38;5;232:*.rom=01;38;5;232:*.sav=00;38;5;232:*.sms=00;38;5;33:*.automount=00;38;5;66:*.desktop=00;38;5;75:*.device=00;38;5;24:*.mount=00;38;5;66:*.path=00;38;5;66:*.service=00;38;5;81:*.snapshot=00;38;5;97:*.socket=00;38;5;75:*.swap=00;38;5;97:*.target=00;38;5;73:*.timer=00;38;5;111:*.c++=01;04;38;5;24:*.C=01;04;38;5;24:*.c=01;38;5;110:*.cc=01;04;38;5;24:*.clj=04;38;5;64:*.cp=01;04;38;5;24:*.cpp=01;04;38;5;24:*.cs=01;04;38;5;74:*.cxx=01;04;38;5;24:*.el=04;38;5;64:*.erl=04;38;5;70:*.fnl=04;38;5;64:*.glsl=04;38;5;70:*.go=04;38;5;70:*.ii=01;04;38;5;24:*.ml=04;38;5;70:*.pas=04;38;5;73:*.rs=04;38;5;73:*.rst=04;38;5;73:*.scala=04;38;5;70:*.swift=04;38;5;73:*.f=00;38;5;29:*.for=00;38;5;29:*.ftn=00;38;5;29:*.h=00;38;5;29:*.h++=00;38;5;29:*.H=00;38;5;29:*.hh=00;38;5;29:*.hpp=00;38;5;29:*.hxx=00;38;5;29:*.s=00;38;5;29:*.S=00;38;5;29:*.sx=00;38;5;29:*.tcc=00;38;5;29:*.am=00;38;5;235:*.in=00;38;5;235:*.old=00;38;5;235:*.cap=00;38;5;29:*.dmp=00;38;5;29:*.dump=00;38;5;99:*.pcap=00;38;5;29:'

# [ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
# vim: ft=sh

source /home/neg/.config/broot/launcher/bash/br
