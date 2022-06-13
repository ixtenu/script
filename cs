#!/usr/bin/env sh
# csearch (codesearch) wrapper script
# This script is intended for a system-wide codesearch index.  Since that
# is how codesearch is meant to work, it's a fairly thin wrapper which only
# provides a shorter name and options.
set -eu

usage() {
	echo "usage: $0 [-f fileregex] [-ib] regex" 1>&$1
	echo "Search codesearch index using $HOME/.csearchindex." 1>&$1
	echo "With -i, case insensitive." 1>&$1
	echo "With -f, restrict search to files matching fileregex." 1>&$1
	echo "With -b, brute force search." 1>&$1
	exit $(($1 - 1))
}

opts=
while getopts d:f:ibh name; do
	case $name in
	f) opts="$opts -f $OPTARG";;
	i) opts="$opts -i";;
	b) opts="$opts -brute";;
	h) usage 1;;
	?) usage 2;;
	esac
done
shift $(($OPTIND - 1))

if [ $# -eq 0 ]; then
	echo "$0: no regex provided for searching" 1>&2
	usage 2
elif [ $# -gt 1 ]; then
	shift
	echo "$0: unexpected arguments: $@" 1>&2
	usage 2
fi

csearch -n $opts "$1"
