# Scripts

Utility scripts for Unix(-like) operating systems.

Portable:

- [72](72): `fmt(1)` wrapper to rewrap text at line width 72.
- [80](80): `fmt(1)` wrapper to rewrap text at line width 80.
- [80p](80p): `fmt(1)` wrapper to rewrap text at line width 80 while preserving
  a prefix (such as a comment token, e.g., `//` or `#`).
- [c](c): `sed(1)` wrapper to comment-out lines.
- [et](et): `expand(1)` wrapper; accepts optional file name arguments.
- [fmtp](fmtp): `fmt(1)` wrapper to rewrap text at a given line width while
  preserving a prefix (such as a comment token, e.g., `//` or `#`).
- [fmtw](fmtw): `fmt(1)` wrapper to rewrap text at a given line width.
- [i](i): indent text by one tab (default) or four spaces (with `-e`).
- [tag](tag): `readtag(1)` wrapper to convert a tag into `file:line`.
- [uc](uc): `sed(1)` wrapper to uncomment-out lines.
- [ui](ui): unindent text by one level (either one tab or four spaces: works
  for either, as long as tabs don't follow spaces).
- [ut](ut): `unexpand(1)` wrapper; accepts optional file name arguments.

Linux-specific:

- [cputemp](linux/cputemp): prints CPU temperature

[install.sh](install.sh) creates symbolic links in `$HOME/bin` for the scripts
in this repository.
