# Scripts

Utility scripts for Unix(-like) operating systems.

## Index

Portable:

- [fmtw](fmtw): `fmt(1)` wrapper to rewrap text at a given line width.
- [fmtp](fmtp): `fmt(1)` wrapper to rewrap text at a given line width while
  preserving a prefix (such as a comment token, e.g., `//` or `#`).  [80p](80p)
  is an alias for `fmtp -w80`.
- [fmtbl](fmtbl): `fmt(1)` wrapper to rewrap bulleted lists at a given line
  width.  [72bl](72bl) and [80bl](80bl) are aliases for `fmtbl -w72` and `fmtbl
  -w80`, respectively.
- [fmts](fmts): a "smart" wrapper around `fmtw`, `fmtp`, and `fmtbl`, which
  examines the input text and picks which script to use.  [72](72) and [80](80)
  are aliases for `fmts -w72` and `fmts -w80`, respectively.
- [et](et): `expand(1)` wrapper; accepts optional file name arguments.
- [ut](ut): `unexpand(1)` wrapper; accepts optional file name arguments.
- [c](c): `sed(1)` wrapper to comment-out lines.
- [uc](uc): `sed(1)` wrapper to uncomment-out lines.
- [i](i): indent text by one tab (default) or four spaces (with `-e`) or an
  arbitrary number of spaces (with `-E n`).
- [ui](ui): unindent text by one level (by default, four spaces and/or one tab,
  which works for either, as long as tabs don't follow spaces; also implements
  `-e` and `-E n` options to unindent spaces only).
- [f](f): search for file names with [fd][ghfd] or, if that's not available,
  with `find(1)`.
- [s](s): recursively search file contents with [rg][ghrg], [ag][ghag], or
  `grep(1)`, in that order of preference.
- [ci](ci) and [cs](cs) are thin wrapper scripts for the `cindex` and `csearch`
  programs from [codesearch][cs].  [pci](pci) and [pcs](psc) are variant
  wrapper scripts for using a project-specific index file.
- [mktag](mktag) and [tag](tag) are [universal-ctag][uct] wrapper scripts.
  `mktag` generates the `tags` file: if PWD is within a Git repository, it
  automatically finds the top-level directory in the repository and runs `ctags
  -R` from there.  `tag` is a `readtag(1)` wrapper which converts the given tag
  into `filename:lineno`.
- [mkexe](mkexe): `touch(1)` and `chmod +x` paths in one command.
- [no9](no9): remove `$PLAN9/bin` (see [plan9port][p9p]) from the `$PATH`, if
  present, and run a command.
- [md2html](md2html): use [pandoc][pd] to convert a Markdown file to HTML and
  optionally open it in a web browser.
- Git subcommand aliases: [gita](gita) (`git add`), [gitc](gitc) (`git commit`),
  [gitcp](gitcp) (`git cherry-pick`), [gitd](gitd) (`git diff`), [gitdc](gitdc)
  (`git diff --cached`), [gitp](gitp) (`git pull`), [git1](git1) `git show`,
  [gits](gits) (`git status`), [gitu](gitu) (`git push`).

[ghfd]: https://github.com/sharkdp/fd
[p9p]: https://9fans.github.io/plan9port/
[ghrg]: https://github.com/BurntSushi/ripgrep
[cs]: https://github.com/google/codesearch
[uct]: https://ctags.io/
[ghag]: https://github.com/ggreer/the_silver_searcher
[pd]: https://pandoc.org/

Linux-specific:

- [cputemp](linux/cputemp): prints CPU temperature
- [zarc](linux/zarc): prints [ZFS][zfs] ARC statistics

[zfs]: https://openzfs.org/

[install.sh](install.sh) creates symbolic links in `$HOME/bin` for the scripts
in this repository.
