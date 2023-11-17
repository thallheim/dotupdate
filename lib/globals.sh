#!/bin/bash

# Global flags, vars, arrays, colour/decoration defs, help- & info strings,
# labels


# VARIABLES/ARRAYS
export VERSION=""
VERSION=$(<"./lib/VERSION")
export INPUT_PATHS=()
export INPUT_PATHS_VALIDATED=()
export DST_DIRS_VALIDATED=()
declare -x -g INC_LIST
declare -x -g DST_ROOT
#export INC_LIST
#export DST_ROOT
# UNUSED: export DST_ROOT_EMACS="${HOME}/dotfiles/emacs/"

# FLAGS
declare -x -g FLAG_VERBOSE=false
export SRC_PATHS_OK=false
export FLAG_STATUS=false


# COLOURS
# Decl.
export RESET=; export BLACK=; export BOLD=; export END_BOLD=; export ITALIC=; export END_ITALIC=; 
export DARKBLUE=; export BLUE=; export DARKGREY=; export GREY=; export DARKRED=; export RED=;
export DARKGREEN=; export GREEN=; export DARKYELLOW=; export YELLOW=; 
export DARKMAGENTA=; export MAGENTA=; export DARKCYAN=; export CYAN=;

RESET=$(tput sgr0)
BLACK=$(tput setaf 0)

BOLD=$(tput bold); END_BOLD=$(tput sgr0)
ITALIC=$(tput sitm); END_ITALIC=$(tput ritm)

DARKBLUE=$(tput setaf 4); BLUE=$(tput setaf 12)
DARKGREY=$(tput setaf 8); GREY=$(tput setaf 7)
DARKRED=$(tput setaf 1); RED=$(tput setaf 9)
DARKGREEN=$(tput setaf 2); GREEN=$(tput setaf 10)
DARKYELLOW=$(tput setaf 3); YELLOW=$(tput setaf 11)
DARKMAGENTA=$(tput setaf 5); MAGENTA=$(tput setaf 13)
DARKCYAN=$(tput setaf 6); CYAN=$(tput setaf 14)


# "ICONS"
export red_cross="$RED""\xE2\x9D\x8C""$RESET"
export green_checkmark="$GREEN""\xE2\x9C\x93""$RESET"
export info_arrow="$CYAN""\xE2\x87\xA8""$RESET"
export info_circle="$CYAN""\xE2\x93\x98""$RESET"
export warn_triangle="\xE2\x9A\xA0"


# LABELS
export error_label="[$RED""ERROR""$RESET""] "
export info_label="[$CYAN""INFO""$RESET""] "
export warn_label="[$YELLOW""WARN""$RESET""] "


# MSG STRINGS
export error_target_newer="$error_label"" Target file is newer: Exiting..."
export info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
export info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."


