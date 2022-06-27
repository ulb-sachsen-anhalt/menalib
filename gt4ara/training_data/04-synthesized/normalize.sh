

# normalize and remove contro char

uconv -f utf-8 -t utf-8 -x '::nfkd; [:Cc:] >' -o out_file.txt in_file
