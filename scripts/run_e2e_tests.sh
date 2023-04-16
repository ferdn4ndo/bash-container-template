#!/bin/bash

set -e
set -o pipefail

echo "Starting E2E tests!"

if [ -f /.dockerenv ]; then
    echo "WARNING: THIS SCRIPT SHOULD BE EXECUTED IN THE DOCKER HOST (OUTSIDE THE SERVICE CONTAINER)";
fi

echo "Checking if the dummy service was successfully executed"
output=$(docker logs bash-container-template --tail=10 | grep "Dummy service execution completed")
if [ "$output" == "" ]; then
    echo "Container output test failed!"
    exit 1
else
    echo "Container output test succeeded!"
fi
