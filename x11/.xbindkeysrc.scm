; http://www.gnu.org/software/guile/guile.html
; Version: 1.8.6
; List of modifier: Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock), Mod3 (CapsLock), Mod4, Mod5 (Scroll).
(use-modules (oop goops))
(define-method (+ (a <list>) (b <list>)) (append a b))
(define-method (+ (a <string>) (b <string>)) (string-append a b))

(ungrab-all-keys)
(grab-all-keys)
(debug)

(set-numlock! #t) ; Now you can use numlock as modifier
(set-scrolllock! #t) ; Now you can use numlock as modifier
(set-capslock! #t) ; Now you can use numlock as modifier

(xbindkey '(Mod4 shift space) "notionflux -e 'toggle_frame_transp()'")
(xbindkey '(Mod4 F11) "notionflux -e 'rofi.mainmenu()'")
(xbindkey '(Mod1 Tab) "notionflux -e 'core.goto_previous()'")
(xbindkey '(Mod4 slash) "notionflux -e 'core.goto_previous()'")
(xbindkey '(Mod4 f) "notionflux -e 'ncmpcpp()'")
(xbindkey '(Mod4 d) "notionflux -e 'console()'")
(xbindkey '(Mod4 e) "~/bin/scripts/scratchpad im")
(xbindkey '(Mod4 Control g) "notionflux -e 'rofi.goto_or_create_ws(core.current())'")
(xbindkey '(Mod1 g) "notionflux -e 'rofi.goto_win(core.current())'")
(xbindkey '(Mod4 u) "udiskie-umount -a")
(xbindkey '(Mod4 c) "~/bin/clip")
(xbindkey '(Mod4 "c:17") "mpc volume 0 \|\| amixer -q set Master 0% mute")
(xbindkey '(Mod4 shift "c:17") "mpc volume 35 \|\| amixer -q set Master 35% unmute")
(xbindkey '(Mod1 control t) "dipser -S")
(xbindkey '(Mod4 shift M) "~/bin/scripts/rofi_mpd")
(xbindkey '(Mod4 shift U) "eject -T")
(xbindkey '(Mod4 apostrophe) "~/bin/scripts/toggle_comp.sh twice && notionflux -e 'notioncore.restart()'")
(xbindkey '(Mod1 grave) "rofi -pid ~/tmp/rofi_runner.pid -show run -location 6 -lines 2 -columns 8 -matching fuzzy -case-sensitive=false -tokenize")
(xbindkey '(Mod4 control shift u) "sudo systemctl suspend")
(xbindkey '(XF86Sleep) "sudo systemctl suspend")
(xbindkey '(Mod4 XF86AudioRaiseVolume) "dash -c 'pactl set-sink-mute 1 ; pactl set-sink-volume 1 +5%'")
(xbindkey '(Mod4 XF86AudioLowerVolume) "dash -c 'pactl set-sink-mute 1 ; pactl set-sink-volume 1 -5%'")
(xbindkey '(XF86AudioMute) "pactl set-sink-mute 1 toggle")
(xbindkey '(XF86AudioLowerVolume) "~/bin/scripts/vol_ -1")
(xbindkey '(XF86AudioRaiseVolume) "~/bin/scripts/vol_ +1")
(xbindkey '(XF86AudioPrev) "mpc prev")
(xbindkey '(XF86AudioStop) "mpc stop")
(xbindkey '(XF86AudioPlay) "mpc toggle")
(xbindkey '(XF86AudioStop) "mpc stop")
(xbindkey '(Mod4 quotedbl) "~/bin/scripts/soft_restart_wm")    
;(xbindkey '(Mod4 control r) "~/bin/scripts/soft_restart_wm")    
;super + control + r ; { c, d, i, r }
;    { \
;        xcalib -c, \
;        xcalib -alter -invert, \
;        xcalib -alter -invert, \
;        xcalib -gc 1.08 -co 97 ~/.config/color_profiles/x230.icm
;    }

;; Time double click test:
;;  - short double click -> run an xterm
;;  - long  double click -> run an rxvt
;(xbindkey-function '(mod4 shift i)
;          (let ((time (current-time))
;            (count 0))
;            (lambda ()
;              (set! count (+ count 1))
;              (if (> count 1)
;              (begin
;               (if (< (- (current-time) time) 1)
;               (run-command "xterm")
;               (run-command "rxvt"))
;               (set! count 0)))
;              (set! time (current-time)))))


;; Chording keys test: Start differents program if only one key is
;; pressed or another if two keys are pressed.
;; If key1 is pressed start cmd-k1
;; If key2 is pressed start cmd-k2
;; If both are pressed start cmd-k1-k2 or cmd-k2-k1 following the
;;   release order
;(define (define-chord-keys key1 key2 cmd-k1 cmd-k2 cmd-k1-k2 cmd-k2-k1)
;    "Define chording keys"
;  (let ((k1 #f) (k2 #f))
;    (xbindkey-function key1 (lambda () (set! k1 #t)))
;    (xbindkey-function key2 (lambda () (set! k2 #t)))
;    (xbindkey-function (cons 'release key1)
;               (lambda ()
;             (if (and k1 k2)
;                 (run-command cmd-k1-k2)
;                 (if k1 (run-command cmd-k1)))
;             (set! k1 #f) (set! k2 #f)))
;    (xbindkey-function (cons 'release key2)
;               (lambda ()
;             (if (and k1 k2)
;                 (run-command cmd-k2-k1)
;                 (if k2 (run-command cmd-k2)))
;             (set! k1 #f) (set! k2 #f)))))

; Example:
;   Shift + b:1                   start an xterm
;   Shift + b:3                   start an rxvt
;   Shift + b:1 then Shift + b:3  start gv
;   Shift + b:3 then Shift + b:1  start xpdf

;(define-chord-keys '(shift "b:1") '(shift "b:3")
;  "xterm" "rxvt" "gv" "xpdf")

;; Here the release order have no importance
;; (the same program is started in both case)
;(define-chord-keys '(alt "b:1") '(alt "b:3")
;  "gv" "xpdf" "xterm" "xterm")
