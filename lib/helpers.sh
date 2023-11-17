#!/bin/bash
# shellcheck disable=2112,2059,2154,3043,3060,3010,3011


# HELPERS

function show_help() {
local line="${DARKGREY}¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨${RESET}"
cat << EOF
${BLUE}Usage:${RESET}
	dotupdate.sh [OPTION]...

${BLUE}Options:${RESET}
  (!) Note: ${DARKGREY}TODO: Remember what I meant to put here.${RESET}

	  Short	    Long	Descr.
	  ${line}
	  -h	    --help	Show help.
	  -v 	    --verbose	Run in verbose mode; always print error summary.
	  -s	    --status	Show status (not implemented)
	  -t	    --test	Verify sources and destination paths are valid,
	  	    		making no filesystem changes. 
	  -V  	    --version	Show version number.
	  ${line}
EOF
}

function strip_home_slug() {
    local input="$1"
    local result="${input/${HOME}}"
    printf "%s" "${result}"
}

function strip_slug() {
    local input="$1"; local result=""

    if [[ $input == ${HOME}"/" ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"; fi
}

function shorten_slug() {
    local input="$1"; local result=""

    if [[ $input == ${HOME}* ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"; fi
    
}
