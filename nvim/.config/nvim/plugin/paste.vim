if executable('xsel')
  command! -range=% PasteSP  <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us 2>/dev/null | tr -d '\n' | xsel -b > /dev/null; xsel -bo
  command! -range=% PasteCL  <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com 2>/dev/null | tr -d '\n' | xsel -b > /dev/null; xsel -bo
  command! -range=% PasteVP  <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net 2>/dev/null | tr -d '\n' | xsel -b > /dev/null; xsel -bo
  command! -range=% PasteIX  <line1>,<line2>w !curl -F 'f:1=<-' ix.io 2>/dev/null | tr -d '\n' | xsel -b > /dev/null; xsel -bo
  command! -range=% PasteTB  <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | xsel -b > /dev/null; xsel -bo
endif
