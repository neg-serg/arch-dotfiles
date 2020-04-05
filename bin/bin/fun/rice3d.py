#!/usr/bin/env pypy3
# -*- coding: utf-8 -*-

# Copyright (C) 2017  Martijn Terpstra

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from math import sin,cos,atan,atan2,sqrt
from math import sin,cos,pi

import math
import os
import shutil
import sys
import time
import argparse

columns, rows = shutil.get_terminal_size((80, 20))

parser = argparse.ArgumentParser()
parser.add_argument("-b", "--blockcharacters", help="Use block characters, may not work with all terminals/fonts", action="store_true")
parser.add_argument("-F", "--framerate",help="Maximum framerate when drawing multiple frames", type=int, default=60)
parser.add_argument("-f", "--framecount", help="Number of frames to render (ignore in combination with --singleframe)", type=int, default=-1)
parser.add_argument("-c", "--columns", help="Number of columns (widht) per frame", type=int, default=columns)
parser.add_argument("-l", "--lines", help="Lines of output (height) per frame", type=int, default=rows)
parser.add_argument("-s", "--script", help="Output as a BASH shell script, to be run later", action="store_true")
parser.add_argument("-W", "--wireframe", help="Draw model as wireframe instead of solid faces", action="store_true")
parser.add_argument("-a", "--ascpectratio", help="Ratio between height and length of a character \"pixel\"", type=float, default=1.5)
parser.add_argument("-A", "--autoscale",help="Automatically scale lighting to model depth", action="store_true")
parser.add_argument("-d", "--dithering", help="Dither colors rather than rounding them down", action="store_true")
parser.add_argument("-t", "--time", help="Time to start animation at", type=int, default=0)
parser.add_argument("-T", "--truecolor", help="Use 24-bit true color output", action="store_true")
parser.add_argument("-R", "--truecolorR", help="Red base value (truecolor)", type=float, default=1.0)
parser.add_argument("-G", "--truecolorG", help="Green base value (truecolor)", type=float, default=1.0)
parser.add_argument("-B", "--truecolorB", help="Blue base value (truecolor)", type=float, default=1.0)
parser.add_argument("-u", "--camerau", help="Camera angle (u)", type=float, default=0.0)
parser.add_argument("-v", "--camerav", help="Camera angle (v)", type=float, default=0.0)
parser.add_argument("-w", "--cameraw", help="Camera angle (w)", type=float, default=0.0)
parser.add_argument("FILE", help=".obj file to be rendered")
parser.add_argument("-g", "--gradient", help="string used to generate a character gradient", default="")
args = parser.parse_args()

# setup text character to represent
ascii_gradient = " .=X"
block_gradient = " ░▒▓█"
grays = [16] + list(range(232,256)) + [255]
c256_gradient = ["\033[48;5;%dm\033[38;5;%dm%s"%(grays[i],grays[i+1],c)\
                 for i in range(len(grays)-1)\
                 for c in ascii_gradient] # requires 256 color support
uc256_gradient = ["\033[48;5;%dm\033[38;5;%dm%s"%(grays[i],grays[i+1],c)\
                 for i in range(len(grays)-1)\
                 for c in block_gradient] # requires unicode support

# we use the $TERM variable to guess color ability
TERM = os.environ['TERM']
color_gradient = c256_gradient if TERM in ["screen-256color","xterm-256color","xterm"] else ascii_gradient

if args.blockcharacters:
    args.gradient = uc256_gradient
elif args.truecolor:
    args.gradient = ["\x1b[48;2;%i;%i;%im "%(int(i*args.truecolorR),int(i*args.truecolorG),int(i*args.truecolorB)) for i in range(255)]
elif args.gradient == "":
    args.gradient = color_gradient

# some global variables, can be changed as the program runs
width, height       = args.columns, args.lines
zoomfactor          = min(width,height)
backgroundchar      = args.gradient[0]
draw_dist_min       = 0
draw_dist_max       = 1
draw_dist_min_frame = 0
draw_dist_max_frame = 1
dither_erorrate     = 0.0
screen              = [[backgroundchar for w in range(width)] for h in range(height)]
z_buffer            = [[-999 for x in range(width)] for y in range(height)]

class Point():
    def __init__(self,x,y,z,color=1):
        self.x,self.y,self.z,self.color = x,y,z,color

class Triangle():
    def __init__(self,p1,p2,p3):
        self.p1,self.p2,self.p3=p1,p2,p3

class Camera():
    def __init__(self,x=0,y=0,z=0,u=0,v=0,w=0,zoom=1.0):
        global zoomfactor
        self.x,self.y,self.z = x,y,z              # position
        self.u,self.v,self.w = u,v,w              # angle
        self.zoom = zoom * zoomfactor # zoom scale

camera = Camera()               # singleton

def char_from_color(x,y,z):
    global draw_dist_min,draw_dist_max,dither_erorrate
    # first we scale z from the doman [draw_dist_min..max] to [0..gradient]
    l =len(args.gradient)
    d = (z - draw_dist_min) / ((draw_dist_max) - draw_dist_min)
    index =int(d*l)
    # keep global "error-rate", if we are dithering incread the value
    # of a pixel every now and then
    if args.dithering and index < len(args.gradient) -1:
        error = d*l - int(index)
        # 4x4 bayer matrix dithering
        if [0,8,2,10,12,4,14,6,3,11,1,9,15,7,13,5]\
           [2*(int(x)%4)+(int(y)%4)]<error*16:
            index += 1

    index = max(0,min(l-1,index))
    return args.gradient[index]

def point_relative_to_camera(point,camera):
    "Gives newcoordinate for a point relative to a cameras position and angle"
    # first we tranlate to camera
    x = point.x - camera.x
    y = point.y - camera.y
    z = point.z - camera.z
    # shorthands so the projection formula is easier to read
    sx,cx,sy,cy,sz,cz = (sin(camera.u),
                         cos(camera.u),
                         sin(camera.v),
                         cos(camera.v),
                         sin(camera.w),
                         cos(camera.w))
    # Rotation around camera
    x, y, z = (cy* (sz*y + cz*x) - sy*z,
               sx* (cy*z + sy*(sz*y + cz*x)) + cx*(cz*y-sz*x),
               cx* (cy*z + sy*(sz*y + cz*x)) - sx*(cz*y-sz*x))
    # add depth perception, keep z>0 to avoid divison by zero
    z_tmp = z+draw_dist_max - draw_dist_min
    # multiple by z axis to get perspective
    x,y = x*z_tmp, y*z_tmp
    # to zoom in/out we multiply each coordinte by a factor
    x,y,z = map(lambda a:a * camera.zoom,[x,y,z])
    color = point.color * (z / camera.zoom)
    # compensate for non-square fonts
    x *= args.ascpectratio
    return Point(x,y,z,color)

def draw_pixel(_x,_y,z):
    "Tranlate point x,y for [-1,1],[-1,1] to [0,height],[0,width] and draw it"
    global screen, width, height, draw_dist_min, draw_dist_max, draw_dist_max_frame, draw_dist_min_frame
    x = int(width/2+_x)
    y = int(height/2-_y)
    # do nothing if the point isn't visible
    if (x >= 0 and x < width) and (y >= 0 and y < height):
        # check z_buffer to prevent draw over pixels in the front
        if z_buffer[y][x] < z and z>=draw_dist_min:
            screen[y][x] = char_from_color(x,y,z)
            z_buffer[y][x] = z
        if args.autoscale:
            if z<draw_dist_min_frame:
                draw_dist_min_frame = z
            if z>draw_dist_max_frame:
                draw_dist_max_frame = z

def draw_line(x1,y1,x2,y2,c1,c2):
    "For every point visible on the line, draw a pixel"
    steps = max(abs(x1-x2),abs(y1-y2))
    if steps>0:
        for s in range(int(steps+1)):
            r1,r2 = s/steps, (1- s/steps)
            x,y = r1*x1 + r2*x2, r1*y1 + r2*y2
            draw_pixel(x,y,(c1*r1 + c2*r2))
    else:
        return

def draw_triangle(p1,p2,p3):
    class Scanbuffer():
        "Class for drawing triangles effeciently"
        def __init__(self):
            global height
            self.minX=[0 for _ in range(height*2)]
            self.maxX=[0 for _ in range(height*2)]
            self.minC=[0 for _ in range(height*2)]
            self.maxC=[0 for _ in range(height*2)]
        def draw_part(self,y_min,y_max):
            for y in range(max(-height,int(y_min)),min(height -1 ,int(y_max))):
                draw_line(self.minX[y],y,self.maxX[y],y,self.minC[y],self.maxC[y])
        def write_line(self,p_low,p_high,handedness):
            global height
            xdist = p_high.x - p_low.x
            ydist = p_high.y - p_low.y
            cdist = p_high.color - p_low.color
            if ydist<=0:
                return
            xstep = xdist / ydist
            cstep = cdist / ydist
            xcurrent = p_low.x
            ccurrent = p_low.color
            for y in range(max(-height,int(p_low.y)),min(height*2,int(p_high.y)+1)):
                if handedness:
                    self.minX[y] = int(xcurrent)
                    self.minC[y] = ccurrent
                else:
                    self.maxX[y] = int(xcurrent)
                    self.maxC[y] = ccurrent
                xcurrent += xstep
                ccurrent += cstep

    # simple bubble sort to order points from low to high
    if p1.y > p2.y:
        p1,p2 = p2,p1
    if p2.y > p3.y:
        p2,p3 = p3,p2
    if p1.y > p2.y:
        p1,p2 = p2,p1
    # scanbuffer allows fast triangle drawing
    sbuffer = Scanbuffer()
    sbuffer.write_line(p1, p2, True)
    sbuffer.write_line(p2, p3, True)
    sbuffer.write_line(p1, p3, False)
    sbuffer.draw_part(p1.y,p3.y)

def draw_triangle_relative(triangle,camera):
    global height,width
    # get three point of triangle
    p1 = point_relative_to_camera(triangle.p1,camera)
    p2 = point_relative_to_camera(triangle.p2,camera)
    p3 = point_relative_to_camera(triangle.p3,camera)

    if args.wireframe:
        draw_line(p1.x ,p1.y, p3.x, p3.y, p1.color, p3.color)
        draw_line(p2.x ,p2.y, p3.x, p3.y, p2.color, p3.color)
        draw_line(p1.x ,p1.y, p2.x, p2.y, p1.color, p2.color)
    else:
        draw_triangle(p1,p2,p3)

def engine_step():
    global screen, width, height, z_buffer, draw_dist_min, draw_dist_max, draw_dist_max_frame, draw_dist_min_frame
    p                 = "\n".join(["".join(line) for line in screen])
    screen            = [[backgroundchar for w in range(width)] for h in range(height)]
    z_buffer          = [[draw_dist_min for x in range(width)] for y in range(height)]
    if args.autoscale:
        draw_dist_max = draw_dist_max_frame
        draw_dist_min = draw_dist_min_frame
        draw_dist_max_frame,draw_dist_min_frame =\
                                                  draw_dist_max_frame * 0.9 + draw_dist_min_frame * 0.1,\
                                                  draw_dist_min_frame * 0.9 + draw_dist_max_frame * 0.1
        camera.zoom = zoomfactor  / ((draw_dist_max-draw_dist_min)**2)
    return "\033[0;0H"+p

def frame_numbers(n=0):
    "Return numbers representing the current frame number"
    if args.framecount > 0:
        for t in range(args.framecount):
            yield t + args.time
    else:
        while True:
            yield n + args.time
            n += 1

def load_obj(filename,camera):
    "Parse an .obj file and return an array of Triangles"
    global draw_dist_min,draw_dist_max,zoomfactor
    obj_file = open(filename)
    vertices,faces = [],[]
    # each line represents 1 thing, we care only about
    # vertices(points) and faces(triangles)
    for line in open(filename).readlines():
        c = line[0]
        if c == "v":            # vertices information
            if line[1] in "tn":  # We ignore textures and normals
                pass
            else:
                coords = list(map(float,line[1:-1].split()))
                vertices.append(Point(coords[0],coords[1],coords[2]))
        elif c == "f":          # face information
            if "/" in line: # check for a/b/c syntax
                if "//" in line: # check for a//b b//c c//d sumtax
                    indexes = [list(map(lambda x:int(x.split("//")[0]),
                                        miniline.split(" ")))[0]-1
                               for miniline in line[2:-1].split()]
                else:
                    indexes = [list(map(int,miniline.split("/")))[0]-1
                               for miniline in line[2:-1].split()]
            else:
                indexes = list(map(lambda x:(int(x) - 1),line[1:-1].split()))

            # If a face has more than 3 vertices, split the face into triangles
            for i in range(0,len(indexes)-2):
                face = Triangle(vertices[indexes[0]],
                                vertices[indexes[i+1]],
                                vertices[indexes[i+2]])
                faces.append(face)
        else:
            pass                # ignore all other information


    # adjust camera for large/small models
    min_x    = min(map(lambda v:v.x,vertices))
    min_y    = min(map(lambda v:v.y,vertices))
    min_z    = min(map(lambda v:v.z,vertices))
    max_x    = max(map(lambda v:v.x,vertices))
    max_y    = max(map(lambda v:v.y,vertices))
    max_z    = max(map(lambda v:v.z,vertices))
    camera.x = (max_x + min_x) / 2
    camera.y = (max_y + min_y) / 2
    camera.z = (max_z + min_z) / 2

    # Pythagorean theorem
    max_dist_from_center = math.sqrt((max_x-min_x)**2 +
                                  (max_y-min_y)**2 +
                                  (max_z-min_z)**2)
    draw_dist_min        = min_z
    draw_dist_max        = max_z
    draw_dist_min_frame  = min_z
    draw_dist_max_frame  = max_z
    camera.zoom          = zoomfactor  / (sum([max_x-min_x,max_y-min_y,max_z-min_z])/3)**2
    return faces

model = load_obj(args.FILE,camera)

if args.script:
    sys.stdout.write("#!/bin/sh\n")
    sys.stdout.write("# Script generated with rice3d\n\n\n")
    sys.stdout.write("echo -e \"\033[1J\"")
    sys.stdout.write("echo -e \"\\033[?25l\"")
else:
    sys.stdout.write("\033[1J")     # escape sequence to clear screen
    sys.stdout.write("\033[?25l")   # hide cursor

try:
    old_time = time.time()
    for t in frame_numbers():
        # rotate camera every frame
        camera.u = args.camerau + 2*pi*t* -0.0005
        camera.v = args.camerav + 2*pi*t* 0.005
        camera.w = args.cameraw + 2*pi*t* 0.00005
        # draw all triangles relative to this new camera
        for _ in model:
            draw_triangle_relative(_,camera)
        # fetch output to be draw
        next_frame = engine_step()

        if args.script:
            # add special formatting if we are creating a script
            sys.stdout.write("\ncat << 'EOF'\n")
            sys.stdout.write(next_frame)
            sys.stdout.write("\nEOF\n")
            sys.stdout.write("sleep %f\n"%(1/args.framerate))
        else:
            new_time  = time.time()
            diff_time = new_time-old_time
            old_time  = new_time
            sys.stdout.write(next_frame)
            # wait till the end of the frame
            if args.framerate > 0:
                time.sleep(max(0,(1/args.framerate)-diff_time))
            else:
                # if framerate <= 0, display the same image forever
                while True:
                    time.sleep(10)

except KeyboardInterrupt:
    pass
finally:
    if args.script:
        sys.stdout.write("\n\necho -e \"\033[?25h\"")   # show cursor again
    else:
        sys.stdout.write("\033[?25h")   # show cursor again
