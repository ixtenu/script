#!/usr/bin/env sh
# add one level of indentation

ichars='	' # tab character

if [ $# -ge 1 -a "$1" = "-e" ]; then
	ichars='    ' # four spaces
	shift
fi
if [ $# -ne 0 ]; then
	echo "$0: unexpected arguments: $@" 1>&2
	exit 1
fi

sed "s/^/$ichars/"
