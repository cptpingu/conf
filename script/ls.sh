#!/bin/sh

GREEN="[01;32m"
WHITE="[0m"
RED="[01;31m"

which gls
if [ $? -eq 0 ]; then
    cmd=gls
else
    cmd=ls
fi

$cmd -lh --color $@ |
sed 's/[dlsp-]\([rwx-].*\)/\1/' |
sed 's/rwx/7/g' |
sed 's/rw-/6/g' |
sed 's/r-x/5/g' |
sed 's/-wx/3/g' |
sed 's/r--/4/g' |
sed 's/-w-/2/g' |
sed 's/--x/1/g' |
sed 's/---/0/g' |
sed "s/^\(755\)/${GREEN}O${WHITE} \1/" |
sed "s/^\(644\)/${GREEN}O${WHITE} \1/" |
sed "s/^\([0-7]\)/${RED}X${WHITE} \1/"
