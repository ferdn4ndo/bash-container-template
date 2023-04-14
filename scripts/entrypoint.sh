#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./functions.sh

printHeader "Bash Container Template"

printMsg "Calling the dummy service..."
./dummy.sh

if [[ "$RUN_CONTAINER_FOREVER" == "1" ]]; then
    printMsg "The RUN_CONTAINER_FOREVER variable is set to 1, entering 'tail -f /dev/null' command..."
    tail -f /dev/null
fi
