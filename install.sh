#!/usr/bin/env sh

outdir=$HOME/bin
mkdir -p "$outdir"

scriptdir="$(cd -- "$(dirname "$0")" 2>&1 >/dev/null && pwd -P)"
cd "$scriptdir"

installfile() {
	fp="$(realpath $1)"
	fn="$(basename $1)"
	lp="$outdir"/"$fn"
	if [ -e "$lp" ]; then
		if [ -L "$lp" ]; then
			ln -svf "$fp" "$lp"
		else
			echo "warning: $lp exists and is not a symbolic link, leaving it" 2>&1
		fi
	else
		ln -sv "$fp" "$lp"
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
