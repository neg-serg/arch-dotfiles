# focus the directional pane (or Vim split if inside Vim) unless maximized:
# (see https://sunaku.github.io/tmux-select-pane.html for more information)
#
#     +----------+---------+------------+-----------------------------+
#     | Encoding | in Vim? | Maximized? | Action taken by key binding |
#     +----------+---------+------------+-----------------------------+
#     | 00 (0)   | no      | no         | focus directional tmux pane |
#     | 01 (1)   | no      | yes        | nothing: ignore key binding |
#     | 10 (2)   | yes     | no         | delegate vim-tmux-navigator |
#     | 11 (3)   | yes     | yes        | focus directional Vim split |
#     +----------+---------+------------+-----------------------------+
#
bind-key -n M-C-d run-shell                                   ' \
  test #{window_zoomed_flag} -eq 0; max=$?;                     \
  cmd="#{pane_current_command}"; test -n "${cmd#*vim}"; vim=$?; \
  if test $max -eq 1 -a $vim -eq 1; then                        \
    tmux send-keys C-w p;                                       \
  else                                                          \
    tmux select-pane -l || tmux select-pane -t 1;               \
  fi                                                            \
'

bind-key -n M-C-h run-shell                                   ' \
  test #{window_zoomed_flag} -eq 0; max=$?;                     \
  cmd="#{pane_current_command}"; test -n "${cmd#*vim}"; vim=$?; \
  set --                                                        \
    "tmux select-pane -L"                                       \
    ""                                                          \
    "tmux send-keys M-h"                                        \
    "tmux send-keys C-w h";                                     \
  shift $(( 2*vim + max ));                                     \
  eval "$1";                                                    \
'
bind-key -n M-C-t run-shell                                   ' \
  test #{window_zoomed_flag} -eq 0; max=$?;                     \
  cmd="#{pane_current_command}"; test -n "${cmd#*vim}"; vim=$?; \
  set --                                                        \
    "tmux select-pane -U"                                       \
    ""                                                          \
    "tmux send-keys M-t"                                        \
    "tmux send-keys C-w k";                                     \
  shift $(( 2*vim + max ));                                     \
  eval "$1";                                                    \
'
bind-key -n M-C-n run-shell                                   ' \
  test #{window_zoomed_flag} -eq 0; max=$?;                     \
  cmd="#{pane_current_command}"; test -n "${cmd#*vim}"; vim=$?; \
  set --                                                        \
    "tmux select-pane -D"                                       \
    ""                                                          \
    "tmux send-keys M-n"                                        \
    "tmux send-keys C-w j";                                     \
  shift $(( 2*vim + max ));                                     \
  eval "$1";                                                    \
'
bind-key -n M-C-s run-shell                                   ' \
  test #{window_zoomed_flag} -eq 0; max=$?;                     \
  cmd="#{pane_current_command}"; test -n "${cmd#*vim}"; vim=$?; \
  set --                                                        \
    "tmux select-pane -R"                                       \
    ""                                                          \
    "tmux send-keys M-s"                                        \
    "tmux send-keys C-w l";                                     \
  shift $(( 2*vim + max ));                                     \
  eval "$1";                                                    \
'

