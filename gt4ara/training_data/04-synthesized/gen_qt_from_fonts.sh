#!/bin/bash
#
# Moheb Mekhaiel
#
# script generates png images out of text for training
# it take the text-file and generates for the list of 
# the fonts x times the image/text couples
# 
#-------------------------------------------------------------------------
#  USAGE: gen_qt_from_fonts   in_txt_file out_dir
#   copy all fonts you need to the subdir fonts!
#   (you have to make sure that the fonts are installed in your system)
#-------------------------------------------------------------------------
if [ "$#" -ne 2 ]; then
  echo "USAGE: $0 in_txt_file out_dir"
  exit 1
fi

if ! [ -f "$1" ]; then
  echo "ERROR: file $1 not found"
  exit 1
fi

if ! [ -d "$2" ]; then
  echo "ERROR: out_dir $2 not found"
  exit 1
fi

IN_TEXT_FILE=$1
OUT_DIR=$2

echo in text: $IN_TEXT_FILE
echo out dir: $OUT_DIR

FONTS_DIR="fonts"
FONT_LIST=`ls $FONTS_DIR | sed -e s/.ttf.*$//`
REPEATITIONS=1

#OPTIONS="--degrade_image --strip -u NFKC"
#OPTIONS="-u NFKC --strip -fs 36 --disable-degradation"
OPTIONS="-u NFC --strip -fs 36 -a 0.9998 -b 0.9998"
#OPTIONS="-u NFKC --strip"

echo found following fonts in subdir fonts $FONT_LIST
echo generate training data for total ${#FONT_LIST} fonts each ${REPEATITIONS} times

for j in $FONT_LIST 
do
  echo generating files for font $j
  for (( i=1; i<=$REPEATITIONS; i++ ))
  do
    ketos linegen -f $j -l ar-EG $OPTIONS -o $OUT_DIR $IN_TEXT_FILE 
    old_names=`ls $OUT_DIR/*.png`
    for k in $old_names
    do
      k_base=`echo $k | sed -e 's/.png//'`
      mv $k ${k_base}_${j}_${i}.png.tmp
      mv ${k_base}.gt.txt ${k_base}_${j}_${i}.gt.txt
    done
  done
done


#rename.ul .png.tmp .png $OUT_DIR/*.png.tmp
# rename does not work for large file number in dir
echo "Please wait while re-naming files, this may take a while ...."
find $OUT_DIR -name '*.png.tmp' -exec sh -c 'x="{}"; mv "$x" "${x%%.*}.png"' \;
