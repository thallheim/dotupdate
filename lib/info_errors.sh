#!/bin/bash
# shellcheck disable=2154,2059 # 'shellcheck source-path=SCRIPTDIR' isn't working
true

function info_circle() {
    if [ "$#" -gt 1 ]; then
	printf "${info_circle} $info_label${BOLD}%s${END_BOLD}: %s\n" "$1" "$2"
    elif [ "$#" -eq 1 ]; then
	printf "${info_circle} ${info_label}${BOLD}%s${END_BOLD}\n" "$1"
    fi
}

function info_arrow() {
    if [ "$#" -gt 1 ]; then
	printf "${info_arrow} $info_label${BOLD}%s${END_BOLD}: %s\n" "$1" "$2"
    elif [ "$#" -eq 1 ]; then
	printf "${info_arrow} ${info_label}${BOLD}%s${END_BOLD}\n" "$1"
    fi
}

function info_checkmark() {
    if [[ "$#" -eq 1 ]]; then
	printf "${green_checkmark} ${info_label}%s\n" "$1"
    elif [[ "$#" -eq 2 ]]; then
	printf "${green_checkmark} $info_label${BOLD}%s:${END_BOLD} %s\n" "$1" "$2"
    fi
}

function info_copied() {
    if [[ "$#" -eq 2 ]]; then
	printf "${green_checkmark} ${info_label} %s ${CYAN}->${RESET} %s\n" "$1" "$2"
    elif [[ "$#" -eq 3 ]]; then
	printf "${green_checkmark} ${info_label} ${BOLD} %s:${END_BOLD} %s ${CYAN}->${RESET} %s\n" "$1" "$2" "$3"
    else
	printf "TODO: Handle error - wrong num args to info_copied\n"
	((error_nonfatal++))
    fi
}

function warn() {
       if [[ "$#" -eq 1 ]]; then
	printf "${warn_triangle} ${warn_label}%s\n" "$1"
       elif [[ "$#" -eq 2 ]]; then
	   printf "${warn_triangle} ${warn_label}${BOLD}%s:${END_BOLD} %s\n" "$1" "$2"
       elif [[ "$#" -eq 3 ]]; then
	   printf "${warn_triangle} ${warn_label}${BOLD}%s ${END_BOLD} %s:\n" "$1" "$2" "$3"
      fi
}

function error() {

    # Print error, increment error counter
    if [[ "$#" -eq 1 ]]; then
	printf "${red_cross}${error_label}%s\n" "$1"
    elif [[ "$#" -eq 2 ]]; then
	printf "${red_cross}${error_label}%s: %s\n" "$1" "$2"
    elif [[ "$#" -eq 3 ]]; then
	printf "${red_cross}${error_label}${BOLD}%s:${END_BOLD} %s \t %s\n" "$1" "$2" "$3"
    else
	printf "You broke the error function. High five! Is nice!\n"
    fi
    ((error_nonfatal++))
}

function print_error_count() {
    local err_count="$((error_fatal + error_nonfatal))"

    printf "\nErrors total:\t%d""$err_count"
    printf "\n"
    printf " %s Fatal:\t%d\n" '-' "$error_fatal"
    printf " %s Non-fatal:\t%d\n" '-' "$error_nonfatal"
}

function exit_done() {
    printf "$info_circle $info_label${BOLD}Exiting...\n${END_BOLD}"
    exit 0
}

function exit_nonfatal() {

    ((error_nonfatal++))
    printf "$warn_triangle $warn_label ${BOLD}Finished, but encountered non-fatal error(s):\n${END_BOLD}"
    printf "\t%s %s %s\n" "  -" "$1" "$2"

    # Check whether to display error counter
#    if [[ "$arg1" = "-ec" ]]; then
#	print_error_count
#    fi
    exit_done
}

function exit_fatal() {

    # Print error, increment error counter

    if [[ "$#" -eq 1 ]]; then
	printf "${red_cross} ${error_label} %s\n" "$1"
    elif [[ "$#" -eq 2 ]]; then
	printf "${red_cross} ${error_label} %s: %s\n" "$1" "$2"
    else
	printf "That's not right. BYE!\n"
    fi
    ((error_fatal++))
    exit 1
}
