#!/usr/bin/env sh
# uncomment-out lines

token='//'

if [ $# -ge 1 ]; then
	token="$1"
	shift
fi
if [ $# -ne 0 ]; then
	echo "$0: unexpected arguments: $@" 1>&2
	echo "usage: $0 comment_token" 1>&2
	exit 1
fi

sed "s@^$token@@"
