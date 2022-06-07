#!/usr/bin/env sh
# find file by name; mostly a fd(1) wrapper to hide naming differences, but
# uses find(1) as a fallback

if command -v fdfind 2>&1 >/dev/null; then
	fdfind "$@"
elif command -v fd 2>&1 >/dev/null; then
	fd "$@"
else
	find . -name "*$1*"
fi
