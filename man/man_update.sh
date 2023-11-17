#!/bin/bash
# shellcheck disable=3010

# Generates a new man page from the .md file (go edit that one if you want to 
# make changes to the generated man page)
#
# TODO: Offer to install man page when done
# TODO: Add cd to script dir

MDU_VERSION=""
MDU_VERSION=$(<"./MDU_VERSION")
arg1="$1"

show_help() {
    printf "%s\n" "Generates a new man page from the .md file (edit that one to\
change the generated man page)"

    printf "\n%s\n" "Note: Generator only; if desired, man page needs \
installing manually for now."

    printf "USAGE:\t%s\n\n" "man_update.sh [OPTION]"
    printf "%s\n" "OPTIONS:"
    printf "\t%s\t%s\n" "-h" "Show help"
    printf "\t%s\t%s\n" "-u" "Generate new man page from source .md file"
    printf "\t%s\t%s\n" "-v" "Show version"
    exit 0
}

if [[ $arg1 == "-h" ]]; then
    show_help

elif [[ $arg1 == "-u" ]]; then
    if command -v pandoc >/dev/null 2>&1; then
	pandoc -s -t man "dotupdate.md" -o "dotupdate.1"
	printf "[INFO] Generated new 'dotupdate.1'\n"
	exit 0
    else
	echo "[ERROR] Couldn't find Pandoc. Ensure it is installed and present \
on \${PATH}."
	exit 1
    fi

elif [[ $arg1 == "-v" ]]; then
    printf "%s\n" "$MDU_VERSION"
    exit 0
else
    show_help
    exit 0
fi
