#!/bin/bash

function cd_own_dir(){ # In case it's run from somewhere other than its own dir
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd "$dir" || exit_fatal "DIR CHANGE FAILED"
}; 
cd_own_dir

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
# (!) The inclusion file needs to end with a blank line, or the last
# entry isn't read. TODO: Work out why. Upd.: also if it still does
#
#
# FILE SUMMARIES:
# ¨¨¨¨¨¨¨¨¨¨¨¨¨¨      
. "./lib/globals.sh"
#       (Most) global vars and arrays
#
# <INCLUSION LIST>.dat - see 'settings.conf'
#	Newline-delimited list of files to be pulled into the dst dir
#
. "./lib/parse_settings.sh"
#       Parses user settings
#
. "./lib/parse_args.sh"
#	Contains the arg parser and related flags
#
. "./lib/info_errors.sh"
#	Strings, labels, functions for info and error handling
#      
. "./lib/file-ops.sh"
#	File operations
#
. "./lib/helpers.sh"
#	Helper functions
#
# settings.conf
#	User settings
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

parse_user_settings
parse_args "$@"
get_override_states
get_file_paths

#printf "user set paths: %s\n" "${!USER_SET_PATHS[@]}"
#printf "inclusion list: %s\n" "$INC_LIST"

