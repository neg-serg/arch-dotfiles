#!/usr/bin/env python

import sys

if len(sys.argv) > 3:

    from PIL import Image

    size_=int(sys.argv[1])
    src_=sys.argv[2]
    dst_=sys.argv[3]

    im = Image.open(src_)
    im.load()

    x_,y_ = im.size
    coeff_ = x_ / size_

    im.resize((int(x_/(coeff_/2)), int(y_/(coeff_/2))), Image.NEAREST).resize((int(x_/(coeff_)), int(y_/(coeff_))), Image.BICUBIC).save(dst_)
