#!/usr/bin/env sh
# readtags(1) (ctags) wrapper script
set -u

if [ $# != 1 ]; then
	echo "usage: $0 symbol_name" 1>&2
	echo "Print filename:lineno for symbol_name in tags file." 1>&2
	exit 1
fi

if [ ! "$(which readtags)" ]; then
	echo "$0: no readtags found in PATH, please install ctags" 1>&2
	exit 1
fi

while [ ! -f tags ]; do
	if [ "$PWD" = "/" ]; then
		echo "$0: no tags file found in PWD or its parents" 1>&2
		exit 1
	fi
	cd ..
done

file=`readtags -t tags $1 | awk -F"\t" '{print $2}'`
if [ "$file" = "" ]; then
	# print nothing when nothing is found
	exit
fi

# use absolute path since that will always work regardless of PWD
file=`readlink -f $file`

# ctags stores a regex, convert that to a line number
pattern=`readtags -t tags $1 | awk -F"\t" '{print $3}' | sed 's!/!!g'`
line=`grep -n "$pattern" $file | awk -F: '{print $1}'`

# print symbol location in standard format
echo $file:$line
