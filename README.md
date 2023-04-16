# Bash Container Template

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ferdn4ndo/bash-container-template/latest)](https://hub.docker.com/r/ferdn4ndo/bash-container-template)
[![E2E test status](https://github.com/ferdn4ndo/bash-container-template/actions/workflows/test_ut_e2e.yaml/badge.svg?branch=main)](https://github.com/ferdn4ndo/bash-container-template/actions)
[![GitLeaks test status](https://github.com/ferdn4ndo/bash-container-template/actions/workflows/test_code_leaks.yaml/badge.svg?branch=main)](https://github.com/ferdn4ndo/bash-container-template/actions)
[![Grype test status](https://github.com/ferdn4ndo/bash-container-template/actions/workflows/test_grype_scan.yaml/badge.svg?branch=main)](https://github.com/ferdn4ndo/bash-container-template/actions)
[![ShellCheck test status](https://github.com/ferdn4ndo/bash-container-template/actions/workflows/test_code_quality.yaml/badge.svg?branch=main)](https://github.com/ferdn4ndo/bash-container-template/actions)
[![Release](https://img.shields.io/github/v/release/ferdn4ndo/bash-container-template)](https://github.com/ferdn4ndo/bash-container-template/releases)
[![MIT license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

An Alpine-based docker image template for bash-based services, including a complete CI workflow with internal Unit Tests (UTs), and E2E Automated Tests (ATs). Protected against code leakage by [GitLeaks](https://github.com/gitleaks/gitleaks-action/) and package vulnerabilities by [Anchore Grype](https://github.com/anchore/grype). Code quality check by [ShellCheck](https://github.com/koalaman/shellcheck).

## Main features

* Lightweight (Alpine-based) docker image;
* Unit tests for the custom bash functions;
* Supports colored messages and provides built-in methods for printing decorated messages;
* Code leakage check on every push by [GitLeaks](https://github.com/gitleaks/gitleaks-action/);
* Third-packages vulnerabilities test on every push by [Anchore Grype](https://github.com/anchore/grype);
* Automatic code quality check on every push by [ShellCheck](https://github.com/koalaman/shellcheck);
* E2E test validation using [custom Github Actions](https://github.com/ferdn4ndo/bash-container-template/blob/main/.github/workflows/test_ut_e2e.yaml);

## Summary

* [Main Features](#main-features)
* [Summary](#summary) *(you're here)*
* [How to Run?](#how-to-run)
  * [Requirements](#requirements)
  * [Preparing the environment](#preparing-the-environment)
  * [Building the image](#building-the-image)
  * [Running in docker-compose](#running-in-docker-compose)
* [Configuring](#configuring)
  * [General Configuration](#general-configuration)
    * [RUN_CONTAINER_FOREVER](#run_container_forever)
* [Testing](#testing)
  * [Unit Tests (UTs)](#unit-tests-uts)
  * [End-to-End (E2E) Tests](#end-to-end-e2e-tests)
* [Contributing](#contributing)
  * [Contributors](#contributors)
* [License](#license)

## How to Run?

### Requirements

To run this service, make sure to comply with the following requirements:

1. Docker is installed and running in the host machine;

2. You have internet connection so docker can download what else is needed;

### Preparing the environment

First of all, clone the `.env.template` file to `.env` in the project root folder:

```bash
cp .env.template .env
```

Then edit the file accordingly. Check the [Configuring](#configuring) section for more information about the variables.

### Building the image

To build the image (assuming the `bash-container-template` image name and the `latest` tag) use the following command in the project root folder:

```bash
docker build -f ./Dockerfile --tag bash-container-template:latest
```

After setting up the environment and building the image, you can now launch a container with it. Considering the `.env` file prepare in the previous section, use the following command in the project root folder:

```bash
docker run --rm -v "./scripts:/scripts" --env-file ./.env --name "bash-container-template" bash-container-template:latest
```

Note that the volume `-v "./scripts:/scripts"` is only needed when you want a hot-reload feature in the development environment.

### Running in docker-compose

As this repository has a Docker image available for pulling, we can add this service to an existing stack by creating a service using the `ferdn4ndo/bash-container-template:latest` identifier:

```yaml
services:
  ...
  bash-container-template:
    image: ferdn4ndo/bash-container-template:latest
    container_name: bash-container-template
    env_file:
      - ./.env
  ...
```

## Configuring

The service is configured using environment variables. They are listed and described below. Use the [Summary](#summary) for faster navigation.

### General Configuration

#### **RUN_CONTAINER_FOREVER**

Determines if the container should exit right after displaying the dummy message (`0` - default), or if the entrypoint should execute a `tail -f /dev/null` command, basically entering in a forever loop of nothing (useful for debugging and entering the container to execute commands manually).

Required: **NO**

Default: `0`

## Testing

The repository pipelines also include testing for code leaks at [.github/workflows/test_code_leaks.yaml](https://github.com/ferdn4ndo/bash-container-template/blob/main/.github/workflows/test_code_leaks.yaml), testing for package vulnerabilities at [.github/workflows/test_grype_scan.yaml](https://github.com/ferdn4ndo/bash-container-template/blob/main/.github/workflows/test_grype_scan.yaml), testing for code quality at [.github/workflows/test_code_quality.yaml](https://github.com/ferdn4ndo/bash-container-template/blob/main/.github/workflows/test_code_quality.yaml), and UTs (which will call the `run_*_tests.sh` scripts) + E2E functional tests at [.github/workflows/test_ut_e2e.yaml](https://github.com/ferdn4ndo/bash-container-template/blob/main/.github/workflows/test_ut_e2e.yaml), which are described in the sections below.

### Unit Tests (UTs)

To execute the ATs, make sure that the `bash-container-template` container is up and running.

This can be achieved by running the `docker-compose.yaml` file:

```bash
docker compose up --build --remove-orphans
```

Then, after the container is up and running, execute this command in the terminal to run the test script inside the `bash-container-template` container:

```bash
# The UTs script must be executed from inside the service container
docker exec -it bash-container-template sh -c "./run_unit_tests.sh"
```

The script will successfully execute if all the tests have passed or will abort with an error otherwise. The output is verbose, give a check.

### End-to-End (E2E) Tests

To execute the ATs (as in the UTs), please first make sure that the `bash-container-template` container is up and running.

Then, **from the host terminal (not inside the container)**, execute the E2E test script:

```bash
# The E2E test script must be executed from the HOST machine (outside the service container)
./scripts/run_e2e_tests.sh
```

The script will successfully execute if all the tests have passed or will abort with an error otherwise. The output is verbose, give a check.

## Contributing

If you faced a bug or would like to have a new feature, open an issue in this repository. Please describe your request as detailed as possible (remember to attach binary/big files externally), and wait for feedback. If you're familiar with software development, feel free to open a Pull Request with the suggested solution.

Any help is appreciated! Feel free to review, open an issue, fork, and/or open a PR. Contributions are welcomed!

### Contributors

[ferdn4ndo](https://github.com/ferdn4ndo)

## License

This application is distributed under the [MIT](https://github.com/ferdn4ndo/bash-container-template/blob/main/LICENSE) license.
