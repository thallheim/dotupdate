#!/bin/bash
## shellcheck disable=2034

export SETTINGS_FILE="./settings.conf"
declare -x -A USER_SETTINGS_ARRAY
declare -x -A USER_SET_PATHS

function parse_user_settings() {
    if [[ -e $SETTINGS_FILE ]]; then
	# Paths to inclusion list & root dest. dir
	while IFS='=' read -r key val; do
	    USER_SET_PATHS["${key}"]=$(eval echo "${val}")
	done < <(awk -f ./lib/get_file_paths.awk "$SETTINGS_FILE")

	INC_LIST=${USER_SET_PATHS["INCLUSION_LIST"]}
	DST_ROOT=${USER_SET_PATHS["DEST_ROOT_DIR"]}

	# Settings overrides
	while IFS='=' read -r key val; do
	    USER_SETTINGS_ARRAY["${key}"]=${val}
	done < <(awk -f ./lib/get_overrides.awk "$SETTINGS_FILE")

	# Verbosity setting check
	if [[ ${USER_SETTINGS_ARRAY["verbose_by_default"]} = "on" ]]; then
	    FLAG_VERBOSE=true;
	fi
    fi
}

function get_file_paths() {
    printf "Set paths:\n"
    for key in "${!USER_SET_PATHS[@]}"; do
	printf "\t- %-20s =\t%s\n" "$key" "${USER_SET_PATHS[$key]}"
    done
}

function get_override_states() {
    printf "Override states:\n"
    for key in "${!USER_SETTINGS_ARRAY[@]}"; do
	printf "\t- %-20s =\t%s\n" "$key" "${USER_SETTINGS_ARRAY[$key]}"
    done
}
