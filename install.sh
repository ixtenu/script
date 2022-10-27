#!/usr/bin/env sh
set -eu
command -v setpipefail >/dev/null && . "$(which setpipefail)"

outdir=$HOME/bin
scriptdir="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"

if [ $# -ne 0 ]; then
	echo "$0: unexpected arguments: $@" 1>&2
	echo "usage: $0" 1>&2
	echo "Create symlinks in $outdir for shell scripts in $scriptdir." 1>&2
	exit 1
fi

mkdir -p "$outdir"
cd "$scriptdir"

installfile() {
	lnvopt='-v'
	[ "$(uname)" = "OpenBSD" ] && lnvopt=

	fp="$(readlink -f $1)"
	fn="$(basename $1)"
	lp="$outdir"/"$fn"
	if [ -e "$lp" ]; then
		if [ -L "$lp" ]; then
			ln -sf $lnvopt "$fp" "$lp"
		else
			echo "warning: $lp exists and is not a symbolic link, leaving it" 2>&1
		fi
	else
		ln -s $lnvopt "$fp" "$lp"
	fi
}

installdir() {
	find "$1" -maxdepth 1 -type f -perm -100 |
	while IFS= read -r fname; do
		if [ "$fname" != "./$(basename $0)" ]; then
			installfile $fname
		fi
	done
}

installdir .

if [ "$(uname)" = "Linux" -a -d ./linux ]; then
	installdir ./linux
fi
if [ "$(uname)" = "FreeBSD" -a -d ./freebsd ]; then
	installdir ./freebsd
fi
if [ "$(uname)" = "OpenBSD" -a -d ./openbsd ]; then
	installdir ./openbsd
fi
