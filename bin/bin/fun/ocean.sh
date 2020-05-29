#!/usr/bin/env dash
#
# Simulate ocean sound.
# Source: https://github.com/vain/bin-pub/blob/master/ocean

exec play -q -n -c 2 \
        synth 0 \
        noise 100 \
        noise 100 \
        lowpass 100 \
        gain 12 \
        tremolo 0.125 80;

# vim: set ts=8 sw=8 tw=0 et :
