#!/usr/bin/env python3
import os
import sys
from PIL import Image
from imagehash import dhash

for t in sys.argv[1], sys.argv[2]:
    if not os.path.exists(t):
        print('')
        sys.exit(0)

if len(sys.argv) == 3:
    img1=Image.open(sys.argv[1])
    img2=Image.open(sys.argv[2])
    ret=(dhash(img1) == dhash(img2))
    if ret:
        print('')
    else:
        print('ok')
