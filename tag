#!/usr/bin/env sh
# readtags(1) (ctags) wrapper script
set -u

# dash doesn't (yet) support pipefail
if [ "$(uname)" = "Linux" -a "$(readlink -f $(which sh))" != "/usr/bin/dash" ]; then
	set -o pipefail
fi

if [ $# != 1 ]; then
	echo "usage: $0 symbol_name" 1>&2
	echo "Print filename:lineno for symbol_name in tags file." 1>&2
	exit 1
fi

if ! command -v readtags 2>&1 >/dev/null; then
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

set -e

files="$(readtags -t tags $1 | awk -F"\t" '{print $2}')"
if [ "$files" = "" ]; then
	# print nothing when nothing is found
	exit 0
fi

# remove duplicate files: if a file has multiple matches, that's handled below
files=$(echo "$files" | uniq)

# for each file where the tag is found
for file in $files; do
	# ctags stores a pattern (possibly multiple) for each tag: extract it
	patterns="$(readtags -t tags $1 | grep "^$1	$file")"
	patterns="$(echo "$patterns" | sed "s!^$1	$file!!")"
	patterns="$(echo "$patterns" | no9 sed "s!.*/\(.*\)/.*!\1!")"
	# escape characters which have special meaning to grep
	patterns="$(echo "$patterns" | sed 's!\*!\\*!g')"
	patterns="$(echo "$patterns" | sed 's!\[!\\[!g')"
	patterns="$(echo "$patterns" | sed 's!\]!\\]!g')"
	patterns="$(echo "$patterns" | sed 's!\.!\\.!g')"

	# use absolute path since that will always work regardless of PWD
	file="$(readlink -f "$file")"

	# for each pattern the tag has in the current file
	for pattern in "$patterns"; do
		# convert the pattern into a line number
		lines="$(no9 grep -n "$pattern" "$file" | awk -F: '{print $1}')"

		# sometimes the pattern will match multiple lines, print them all
		for line in $lines; do
			# print symbol location in standard format
			echo "$file:$line"
		done
	done
done
