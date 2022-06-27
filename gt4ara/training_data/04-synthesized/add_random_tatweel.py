# -*- coding: utf-8 -*-

# instert random tatweel in arabic text

import os
from os import listdir
import sys
import unicodedata
import random

if(len(sys.argv) != 3):
    print("usage: ", sys.argv[0], "text_file", "out_file")
    sys.exit()

if  os.path.exists(sys.argv[1]) :
  f_in = open(sys.argv[1],'r')
else:
  print('file ', sys.argv[1], 'does not exists! ')
  sys.exit(-1)

f_out=open(sys.argv[2], 'w')


punctuation = ['؛','،',':',' —','؛','،',':',' —','.','؛','،',':',' —','؟',')','(',']','[']
numerals = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩']
alphabet = ['ا','ب','ت','ث','ج','ح','خ','د','ذ','ر','ز','س','ش','ص','ض','ط','ظ','ع','غ','ف','ق','ك','ل','م','ن','ه','و','ي']


accepts_tatweel_after =['ب','ت','ث','ج','ح','خ','س','ش','ص','ض','ط','ظ','ع','غ','ف','ق','ك','م','ن','ه','ي']

for line in f_in:
  print(line)

  new_line=''
  words=line.split()
  for word in words:
    #if not randomly selected move to next word
    print ("word:", word)
    rand = random.randint(0,180)
    if (rand > 120):
      new_line += word+' '
      continue

    str_len = len(word)
    if str_len <4 :
      new_line += word+' '
      continue
    
    rand = random.randint(0, str_len-2)
    
    #if word[rand]  in  accepts_tatweel_after and word[rand+1] not in punctuation:
    if word[rand]  in  accepts_tatweel_after and word[rand+1].isalpha():
      repeatitions= 1 + (random.randint(0,30)>22) +  (random.randint(0,30)>25)
      tatweel="".join(['ـ']*repeatitions)
      new_word=word[:rand+1]+tatweel+word[rand+1:]
      print(rand, str_len, word, word[rand], new_word)
    else :
      print(word[rand], '## can not take tatweel ###')
      new_word=word
    
    new_line += new_word+' '    

  f_out.write(new_line+'\n')

f_in.close()
f_out.close()
