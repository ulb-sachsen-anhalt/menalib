# Based on https://github.com/tesseract-ocr/tesstrain/wiki/Arabic-Handwriting
# https://github.com/Shreeshrii/tesstrain-JSTORArabic

# USAGE:
#  ./fix_ara  

# Remove images and lines with [a-zA-Z] and other non-Arabic characters

rm -f $(grep -e [a-zA-Z] *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep -e 'ï|è|û|Û|ô|ā|à|ü' *.txt|sed s/gt.txt.*$/*/)

# Remove empty texts (files contain only a line feed) which cannot be used for training.
rm -f $(find . -size 1c|sed s/.gt.txt/.*/)
rm -f $(find . -size 0|sed s/.gt.txt/.*/)

# Remove images and their gt.txt which were written from top to bottom or from bottom to top.
# The heuristics here assumes that such images have a 3 digit width and a 4 digit height.
rm -f $( file *.png|grep ", ... x ....,"|sed s/png/*/)

# from @M3ssman
#echo 9 rm -v $(grep -e '[\(|\)|\<|\||\>|«|»]' *.txt | sed s/gt.txt.*$/*/)
rm -f $(find . -size -4c | sed s/.gt.txt/.*/)
#rm -v $(file *.png | grep ", . x " | sed s/png/*/)
#rm -v $(file *.png | grep ", .. x .," | sed s/png/*/)

# Replace Farsi numbers by EAN - This is needed because of wrong transcription.
sed -i -f fixpersiannumbers.sed *.gt.txt

# Replace Western Arabic Numbers by EAN - This is needed because of wrong transcription.
sed -i -f fixwesternnumbers.sed *.gt.txt

# Remove RLM and LRM
sed -i -e 's/‎//g' *.gt.txt
sed -i -e 's/‏//g' *.gt.txt

# REMOVE Non-Arabic LOW FREQ char lines
rm -f $(grep % *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep √ *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep ❊ *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep × *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep — *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep ٪ *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep = *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep ‘ *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep '`' *.txt|sed s/gt.txt.*$/*/)

rm -f $(grep $'\u0656' *.txt|sed s/gt.txt.*$/*/) #U+0656  b'\xd9\x96' ARABIC SUBSCRIPT ALEF
rm -f $(grep $'\u066e' *.txt|sed s/gt.txt.*$/*/) #U+066E  b'\xd9\xae' ARABIC LETTER DOTLESS BEH
rm -f $(grep $'\u0670' *.txt|sed s/gt.txt.*$/*/) #U+0670  b'\xd9\xb0' ARABIC LETTER SUPERSCRIPT ALEF
rm -f $(grep $'\u0672' *.txt|sed s/gt.txt.*$/*/) #U+0672  b'\xd9\xb2' ARABIC LETTER ALEF WITH WAVY HAMZA ABOV
rm -f $(grep $'\u0673' *.txt|sed s/gt.txt.*$/*/) #U+0673  b'\xd9\xb3' ARABIC LETTER ALEF WITH WAVY HAMZA BELOW
rm -f $(grep $'\u067e' *.txt|sed s/gt.txt.*$/*/) #U+067E  b'\xd9\xbe' ARABIC LETTER PEH
rm -f $(grep $'\u06a1' *.txt|sed s/gt.txt.*$/*/) #U+06A1  b'\xda\xa1' ARABIC LETTER DOTLESS FEH
rm -f $(grep $'\u06a7' *.txt|sed s/gt.txt.*$/*/) #U+06A7  b'\xda\xa7' ARABIC LETTER QAF WITH DOT ABOVE
rm -f $(grep $'\u06a9' *.txt|sed s/gt.txt.*$/*/) #U+06A9  b'\xda\xa9' ARABIC LETTER KEHEH
rm -f $(grep $'\u06cc' *.txt|sed s/gt.txt.*$/*/) #U+06CC  b'\xdb\x8c' ARABIC LETTER FARSI YEH
rm -f $(grep $'\u0672' *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep $'\u0673' *.txt|sed s/gt.txt.*$/*/)
rm -f $(grep $'\ufe9f' *.txt|sed s/gt.txt.*$/*/) #U+FE9F  b'\xef\xba\x9f' ARABIC LETTER JEEM INITIAL FORM


# Remove space before Arabic Comma
sed -i -e 's/ ،/،/g' *.gt.txt

# remove Tatweel
sed -i s/$'\u0640'//g *.gt.txt

