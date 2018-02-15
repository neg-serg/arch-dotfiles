#!/bin/sh
gcc -D_FORCE_OCLOEXEC -march=native -Os -std=gnu11 send.c -o send
