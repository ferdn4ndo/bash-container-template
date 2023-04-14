#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./functions.sh

function assertStringEquals() {
    if [[ "$1" == "$2" ]]; then
        printSuccess "Success asserting that string is '${2}'!"
    else
        printFailure "Failed asserting that string is '${2}' (actual value: '${1}')!"
        exit 1
    fi
}

function assertStringContains() {
    filteredLine=$(echo "${1}" | grep -s "${2}" || true)
    if [[ "$filteredLine" != "" ]]; then
        printSuccess "Success asserting that string contains '${2}'!"
    else
        printFailure "Failed asserting that string contains '${2}'!"
        exit 1
    fi
}

function assertStringEmpty() {
    if [[ "$1" == "" ]]; then
        printSuccess "Success asserting that string is empty!"
    else
        printFailure "Failed asserting that string is empty (actual value: '${1}')!"
        exit 1
    fi
}

function assertStringDifferent() {
    if [[ "$1" != "$2" ]]; then
        printSuccess "Success asserting that string '${1}' is different than '${2}'!"
    else
        printFailure "Failed asserting that string is different than '${1}'!"
        exit 1
    fi
}
