#!/usr/bin/env sh
# recursive file search

if command -v rg 2>&1 >/dev/null; then
	rg --vimgrep "$@"
elif command -v ag 2>&1 >/dev/null; then
	ag --nocolor --noheading --nobreak "$@"
else
	no9 grep -Rn "$@"
fi

if [ $? -ne 0 ]; then
	echo Not found 1>&2
fi
