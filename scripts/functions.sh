#!/bin/bash

set -e
set -o pipefail

# shellcheck disable=SC1091
source ./strings.sh

###
### Custom service methods will go here
###

function printLoremIpsum() {
    printMsg "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    printMsg "Sed et ipsum molestie justo aliquam lacinia vitae in nibh."
    printMsg "Sed ultricies aliquam dapibus. Mauris sodales velit at enim"
    printMsg "lobortis eleifend. Aenean ac libero nec neque maximus"
    printMsg "scelerisque. Praesent venenatis sem utefficitur tempus. Maecenas"
    printMsg "a nulla at erat aliquam luctus id sed est. Nullam lacinia vel"
    printMsg "enim ac sodales. Donec ex velit, finibus quis massa hendrerit"
    printMsg "interdum nibh. Morbi fermentum felis a feugiat dictum."
}
