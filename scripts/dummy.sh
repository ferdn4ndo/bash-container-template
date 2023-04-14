#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./functions.sh

printMsg "Hello world!!"

printLoremIpsum

printSuccess "Dummy service execution completed!"
