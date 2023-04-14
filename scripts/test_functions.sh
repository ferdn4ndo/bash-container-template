#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./asserts.sh

###
### The UTs of the custom service methods (in functions.sh) will go here
###

testPrintLoremIpsum() {
    printMsg "Testing the printLoremIpsum method"

    exec 5>&1
    output=$(printLoremIpsum)

    assertStringContains "${output}" "Lorem ipsum dolor sit amet"
}

if [ -z "$1" ]; then
    printWarning "No argument supplied, running all the tests in the file!"

    testPrintLoremIpsum
else
    # shellcheck disable=SC2199
    [[ "$@" =~ 'testPrintLoremIpsum' ]] && ( testPrintLoremIpsum )
fi

printSuccess "ALL TESTS PASSED!"
