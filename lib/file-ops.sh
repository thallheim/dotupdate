#!/bin/bash

# GLOBALS & HELPER FUNCTIONS
# Colours/decoration/"icons"/labels/strings, usage/help, info, errors
. "./lib/globals.sh"; . "./lib/helpers.sh"; . "./lib/info_errors.sh"


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# FILE OPS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# Verify the inclusion list exists and read it into input_paths()
function get_src_paths() {
    if [ -e "${INC_LIST}" ]; then
	while IFS= read -r line; do
	    INPUT_PATHS+=("$(eval echo "$line")")
	done < "$INC_LIST"
	# VERBOSE
	if [[ ${FLAG_VERBOSE} == true ]]; then
	    info_checkmark \
		"Inclusion list OK" "${#INPUT_PATHS[@]} entries to validate"; fi
    else
	exit_fatal "Could not read inclusion list: " "${INC_LIST}"
    fi
}

# Verify src files are readable
function verify_src_readable() {
    info_circle "Verifying sources"
    for path in "${INPUT_PATHS[@]}"; do
	if [[ -r "${path}" ]]; then
	    INPUT_PATHS_VALIDATED+=("$path")
	    local path_stripped=""
	    path_stripped="$(shorten_slug "$path")"
	    # VERBOSE:
	    if [[ $FLAG_VERBOSE == true ]]; then
		info_checkmark "  Valid" "${path_stripped}"; fi
	else
	    local notfound=""
	    local result=""
	    notfound="$(shorten_slug "$path")"
	    result="${notfound/${HOME}/~}"
	    warn "Source file not found" "'${result}'"
	fi

	# Make sure at least one src file is readable, otherwise just exit
	# TODO: Implement the actual check
	if [[ ! "${#INPUT_PATHS_VALIDATED[@]}" -gt 0 ]]; then
	    ((error_fatal++))
	    exit_fatal "Failed to read sources. Check permissions if files are known good."; fi
    done
}

# Get folder structure from validated input paths
function get_dst_dirs() {
    info_circle "Validating source dir structures"

    for path in "${INPUT_PATHS_VALIDATED[@]}"; do
	#printf "RAW PATH: %s\n" "${path}"
	local file_stripped=""; local result=""
	file_stripped="$(dirname "$path")"

	# If it's not the home folder itself, process it
	if [[ ! "$file_stripped" = "${HOME}" ]]; then
	    result="$file_stripped"

	    # Only add the path if it isn't already in the array
	    if ! [[ ${DST_DIRS_VALIDATED[*]} =~ ${result} ]]; then
		DST_DIRS_VALIDATED+=("${result}")
		# VERBOSE
		if [[ $FLAG_VERBOSE == true ]]; then
		    info_checkmark "  Valid" "$(shorten_slug "${result}")"; fi
	    fi
	fi
    done
}

# TODO: Split dst path verification into new function so the test can run it
#	without creating the folders
# Check if dst dirs exist and create as necessary
function mk_dst_dirs() {
    if [[ ! -d "${DST_ROOT}" ]]; then
	mkdir -p "${DST_ROOT}"
	info_circle "Created destination root directory"
    else
	info_checkmark "Destination root directory exists"
    fi

    # Create destination dirs
    info_circle "Creating destination directories"

    for path in "${DST_DIRS_VALIDATED[@]}"; do
	local dir=""
	dir="$(strip_home_slug "$path")"
	mkdir -p "${DST_ROOT}/${dir}"
	# VERBOSE
	if [[ $FLAG_VERBOSE == true ]]; then
	    info_checkmark "  Created" "${DST_ROOT/${HOME}/\~}${dir}"; fi
    done
}

# 0 if src is newer, else 1
function confirm_src_newer() {
    local src="$1"
    local dst="$2"

    if [[ -e $src ]]; then
	if [[ $src -nt $dst ]]; then
	    return 0
	else
	    return 1
	fi
    fi
}

function copy_newer_files() {
    info_circle "Start copy operations"
    local to_copy=()
    local skipped=()


    for src in "${INPUT_PATHS_VALIDATED[@]}"; do
	local dst=""
	dst="${DST_ROOT}$(strip_home_slug "$src")"

	if [[ "${src}" -nt "${dst}" ]]; then
	    to_copy+=("$src")
	else
	    skipped+=("$src")
	fi
    done

    for file in "${to_copy[@]}"; do
	local dst=""
	dst="${DST_ROOT}$(strip_home_slug "$file")"
	cp "${file}" "${dst}"
    done
    if [[ $FLAG_VERBOSE == true ]]; then
	for file in "${to_copy[@]}"; do
	    local dst=""
	    dst="${DST_ROOT}$(strip_home_slug "$file")"
	    info_copied " $(shorten_slug "${file}")" "$(shorten_slug "${dst}")"
	done
    fi

    if [[ -n "${skipped[*]}" && "${FLAG_VERBOSE}" == true ]]; then
	for skipped_file in "${skipped[@]}"; do
	    warn "Skipped - source is older" "$(shorten_slug "${skipped_file}")"
	done
    fi
    info_checkmark "Copy operations complete"
}
