---
title: dotupdate
section: 1
header: User manual
footer: dotupdate 0.0.1
date: November 17, 2023
---
# NAME
dotupdate - basic dotfile repo updater

# SYNOPSIS
**dotupdate** [*OPTION*]...

# OPTIONS
**-h**
: show help message

**-u**
: Update; generate new 'dotupdate.1'

**-V**
: show version

# DESCRIPTION
*Note*: Not for use in production!

**dotupdate** is a utility that tries to help keep a dotfile repo updated, by
turning it into a mini-monolith.  It keeps simple newline-delimited lists of
source files which it pulls into a user-configurable destination directory,
where it recreates the folder structures of any (valid & readable) source files
it's been given. This requires no user interaction beyond deciding which files
are to be included. Defaults to warning before overwriting a newer file with an
older one.

# AUTHORS
Written by thallheim <thall@thallheim.com>

# SEE ALSO
- Full sources at: <https://github.com/thallheim/dotupdate>
- Pandoc manual at: <https://pandoc.org/MANUAL.html>
