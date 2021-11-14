#!/bin/sh

xsel -o | echo #sed 's/[+\"]//g;' | awk '{$1=$1}1' | print
xsel -op | echo #sed 's/[+\"]//g;' | awk '{$1=$1}1' | print
xsel -os | echo #sed 's/[+\"]//g;' | awk '{$1=$1}1' | print
