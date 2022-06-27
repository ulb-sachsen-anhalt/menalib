# -*- coding: utf-8 -*-

import os
from os import listdir
import sys
import unicodedata
import random

if(len(sys.argv) != 2):
    print("usage: ", sys.argv[0], "text_file")
    sys.exit()


txt_file = open(sys.argv[1]).read()

chars = {}
for char in txt_file:
    if char not in chars:
        chars[char] = 1
    else:
        chars[char] +=1
        
keys = list(chars.keys())
keys.sort()
no=0
print("occurances | Codepoint | UTF-8 | NAME ")
for char in keys:
    if char != '\n':
        if not char.isprintable:
            print("Warning: ignoring non printable char")

        no +=1
        print("%8.i"%chars[char],  char,  
             " U+%4.4X "%ord(char), char.encode('utf-8'),  unicodedata.name(char, "XXXXX NOT DEFINED XXXX"))
print ("-------------------------------------------")
print("Total unique chars all:", len(keys), " - defined:", no )




