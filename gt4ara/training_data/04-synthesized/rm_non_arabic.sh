#!/bin/bash
# apply to a text file, will delete all lines that mactch with certain chars
# USAGE: rm_non_arabic   in_file

if [ "$#" -ne 1 ]; then
  echo "USAGE: $0 in_file"
  exit 1
fi

if ! [ -f "$1" ]; then
  echo "ERROR: file $1 not found"
  exit 1
fi

in_file=$1

# delete the line if it contains one of the following
sed -i -n '/[0-9]/!p' $in_file
sed -i -n '/[a-z]/!p' $in_file
sed -i -n '/[A-Z]/!p' $in_file


sed -i /$'\u0656'/d  $in_file  #U+0656  b'\xd9\x96' ARABIC SUBSCRIPT ALEF
sed -i /$'\u066e'/d  $in_file  #U+066E  b'\xd9\xae' ARABIC LETTER DOTLESS BEH
sed -i /$'\u0670'/d  $in_file  #U+0670  b'\xd9\xb0' ARABIC LETTER SUPERSCRIPT ALEF
sed -i /$'\u0672'/d  $in_file  #U+0672  b'\xd9\xb2' ARABIC LETTER ALEF WITH WAVY HAMZA ABOV
sed -i /$'\u0673'/d  $in_file  #U+0673  b'\xd9\xb3' ARABIC LETTER ALEF WITH WAVY HAMZA BELOW
sed -i /$'\u067e'/d  $in_file  #U+067E  b'\xd9\xbe' ARABIC LETTER PEH
sed -i /$'\u06a1'/d  $in_file  #U+06A1  b'\xda\xa1' ARABIC LETTER DOTLESS FEH
sed -i /$'\u06a7'/d  $in_file  #U+06A7  b'\xda\xa7' ARABIC LETTER QAF WITH DOT ABOVE
sed -i /$'\u06a9'/d  $in_file  #U+06A9  b'\xda\xa9' ARABIC LETTER KEHEH
sed -i /$'\u06cc'/d  $in_file  #U+06CC  b'\xdb\x8c' ARABIC LETTER FARSI YEH
sed -i /$'\u0672'/d  $in_file
sed -i /$'\u0673'/d  $in_file
sed -i /$'\ufe9f'/d  $in_file  #U+FE9F  b'\xef\xba\x9f' ARABIC LETTER JEEM INITIAL FORM


# don't delete lines with Tatweel, just remove the Tatweel
sed -i s/$'\u0640'//g $in_file

exit 0



