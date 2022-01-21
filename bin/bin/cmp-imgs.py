#!/usr/bin/env python3

import sys
from PIL import Image
from imagehash import dhash

if dhash(Image.open(sys.argv[1])) == dhash(Image.open(sys.argv[2])):
    sys.exit(0)
else:
    sys.exit(2)
