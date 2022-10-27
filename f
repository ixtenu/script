#!/usr/bin/env sh
# find file by name; mostly a fd(1) wrapper to hide naming differences, but
# uses find(1) as a fallback
set -u

if command -v fdfind >/dev/null 2>&1; then
	fdfind "$@"
elif command -v fd >/dev/null 2>&1; then
	fd "$@"
else
	find . -name "*$1*"
fi
