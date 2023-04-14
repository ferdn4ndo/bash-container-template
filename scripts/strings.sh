#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./colors.sh

TERMWIDTH=80

function printMsg() {
    if [ -z "$2" ]; then
        # No specific color informed, perform e regular echo
        echo "$1"

        return
    fi

    # shellcheck disable=SC2059
    printf "${2}${1}${COLOR_OFF}\n"
}

function printTitle() {
    titleSize=${#1}

    sizeLeft=$(( ((TERMWIDTH-titleSize)/2) - 1 ))
    sizeRight=$(( ((TERMWIDTH-titleSize+1)/2) - 1 ))

    if [ $sizeLeft -gt 0 ] && [ $sizeRight -gt 0 ]; then
        title="$(printf '=%.0s' $(seq 1 $sizeLeft)) ${1} $(printf '=%.0s' $(seq 1 $sizeRight))"
    else
        title="${1}"
    fi

    printMsg "$title" "${COLOR_BACKGROUND_BLUE}${COLOR_BOLD_WHITE}"
}

function printHeader() {
    spacer=$(printf '=%.0s' $(seq 1 $TERMWIDTH))

    printMsg ""

    printMsg "$spacer" "${COLOR_BACKGROUND_BLUE}${COLOR_BOLD_WHITE}"

    printTitle "${1}"

    printMsg "$spacer" "${COLOR_BACKGROUND_BLUE}${COLOR_BOLD_WHITE}"

    printMsg ""
}

function printSuccess() {
    printMsg "${1}" "${COLOR_BACKGROUND_GREEN}${COLOR_BOLD_WHITE}"
}

function printWarning() {
    printMsg "${1}" "${COLOR_BACKGROUND_YELLOW}${COLOR_BOLD_WHITE}"
}

function printFailure() {
    printMsg "${1}" "${COLOR_BACKGROUND_RED}${COLOR_BOLD_WHITE}"
}
