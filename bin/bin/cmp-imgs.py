#!/usr/bin/env python3

import sys
from PIL import Image
from imagehash import dhash

if len(sys.argv) == 3:
    sys.exit((dhash(Image.open(sys.argv[1])) == dhash(Image.open(sys.argv[2])))*2)
