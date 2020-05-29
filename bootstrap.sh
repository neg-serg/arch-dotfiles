#!/bin/sh
find -maxdepth 1 -type d -not -path '*/\.*' -printf '%P\n' | xargs stow -v 
