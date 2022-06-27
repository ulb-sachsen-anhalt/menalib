# -*- coding: utf-8 -*-
# Moheb Mekhaiel
#
# go throug all png files  and rotate randomly rotate between -1 - +1 degree
# 

import random
import os
import sys
import math as mt

from PIL import Image
import PIL
from torch import absolute

def rotate_img(img_file, degree):
    img = Image.open(img_file, 'r')
    if 'dpi' in img.info:
        res_dpi = img.info['dpi']
    else:
        res_dpi = 300

    img = img.rotate(degree, PIL.Image.BICUBIC, expand = 1, fillcolor='white')
  
    #img_base_name = os.path.basename(img_file)
    #img_dir = os.path.dirname(img_file)        
    #img_new_name =  "%s/%s_rot.png" % (img_dir, img_base_name.split('.')[0])
    #print(img_new_name)
    #img.save(img_file, dpi=res_dpi)
    img.save(img_file)
    img.close()
    return(img.size)

########
# MAIN #
########
if __name__ == "__main__":

    if len(sys.argv) != 2:
        print("USAGE: random_rotate  img_dir")
        print("       will look for every png file in given dir, randomly rotate")
        print("       between -1.0 - 1.0 degree, and set the dpi to 300")
        #raise Exception("synatx error, number of expected args not met")
        sys.exit(1)

    in_dir = sys.argv[1]
    if not os.path.isdir(in_dir):
        print("Error: in_dir {} does not exist ".format(in_dir))
        sys.exit(1)

    img_files = sorted([f for f in os.scandir(in_dir) if f.name.endswith(".png")], key=lambda f: f.name)
    for i in img_files:
        img_file = i.path
        degree = 1.9*random.random()-1
        if(abs(degree) > 0.2):
            size = rotate_img(img_file, degree)
            print('rotating file: ', i.name, 'by ', degree, 'degree')

        print(' file: ', i.name, 'will not be rotated')
  
