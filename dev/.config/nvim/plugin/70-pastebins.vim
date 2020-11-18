command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d ' ' | xclip -i -selection clipboard
command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d ' ' | xclip -i -selection clipboard
command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d ' ' | xclip -i -selection clipboard
command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d ' ' | xclip -i -selection clipboard
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d ' ' | xclip -i -selection clipboard
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d ' ' | xclip -i -selection clipboard
