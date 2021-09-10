#!/usr/bin/env python3

import sys
from PIL import Image
from imagehash import dhash

try:
    print(
        dhash(Image.open(sys.argv[1])) == dhash(Image.open(sys.argv[2]))
    )
except Exception:
    print("Error")
