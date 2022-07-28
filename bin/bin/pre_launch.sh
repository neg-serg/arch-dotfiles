#!/bin/dash
systemctl --user stop picom # Disable compositor
nvidia-settings --assign CurrentMetaMode="DP-0: 3840x2160_120 +0+0 {ForceCompositionPipeline=Off, AllowGSYNCCompatible=On}, HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=Off}"
xrandr --output HDMI-1 --off #Disable 2º screen