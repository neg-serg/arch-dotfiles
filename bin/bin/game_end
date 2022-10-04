#!/bin/dash
xrandr --output HDMI-0 --auto # Re-enable 2º screen
# Re-enable composition pipeline
nvidia-settings --assign CurrentMetaMode="DP-0: 3840x2160_120 +0+0 {ForceCompositionPipeline=On, AllowGSYNCCompatible=On}, HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
systemctl --user start picom # Re-enable your compositor
