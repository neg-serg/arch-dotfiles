# binary space partitioned layouts (dwindle, spiral)
# https://sunaku.github.io/tmux-layout-dwindle.html
bind-key M-w run-shell '~/bin/scripts/tmux/tmux-layout-dwindle brhc && ~/bin/scripts/tmux/tmux-redraw-vim'
bind-key M-C-w run-shell '~/bin/scripts/tmux/tmux-layout-dwindle trhc && ~/bin/scripts/tmux/tmux-redraw-vim'
bind-key M-v run-shell '~/bin/scripts/tmux/tmux-layout-dwindle brvc && ~/bin/scripts/tmux/tmux-redraw-vim'
bind-key M-C-v run-shell '~/bin/scripts/tmux/tmux-layout-dwindle blvc && ~/bin/scripts/tmux/tmux-redraw-vim'
