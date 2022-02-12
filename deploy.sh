#!/bin/bash
#
# Deploy AWS VPC and so on.


BASE_PASH="$(git rev-parse --show-toplevel)"
export BASE_PASH

util_path="$BASE_PASH/utils.sh"
source "$util_path"


if [ $# -ne 2 ]; then
    err "Usage: $CMDNAME environment region"
    exit 1
fi

# check environment

set_parameters_by_env_region "$@"

if ! deploy; then
    search_cloudformation_err 
fi