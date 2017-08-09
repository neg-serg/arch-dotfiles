#!/bin/bash

desk=$(
        i3-msg -t get_workspaces |
        jshon -a -e focused -u -p -e name -u |
        grep -A 1 true | tail -n 1
)

echo ${desk}
