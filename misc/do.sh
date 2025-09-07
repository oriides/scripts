#!/usr/bin/env bash

set -euo pipefail

red='\033[1;31m'
green='\033[1;32m'
blue='\033[94m'
normal='\033[0m'

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function log_fail {
    echo >&2 -e "${red}$1${normal}"
}

function log_ok {
    echo >&2 -e "${green}$1${normal}"
}

function log_debug {
    echo >&2 -e "${blue}$1${normal}"
}

# Command dispatcher for showing man-like usage information when script
# is run without any parameters
function task_usage {
    echo "Usage: $0 <subcommand>"
    sed -n 's/^##//p' <"$0" | column -t -s ':' | sed -E $'s/^/\t/' | sort
}

## help: prints usage instructions for the script
function task_help {
    task_usage
}

#===============================================================================

# TODO: INSERT YOUR FUNCTIONS HERE

#===============================================================================

cmd=${1:-}
shift || true
resolved_command=$(echo "task_${cmd}" | sed 's/-/_/g')
if [[ "$(LC_ALL=C type -t "${resolved_command}")" == "function" ]]; then
    pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
    ${resolved_command} "$@"
else
    task_usage
fi
