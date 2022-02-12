#!/bin/bash
# 
# Utililities for Deploy

#######################################
# STDOUT.
# Arguments:
#   Error Message
#######################################
function err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

#######################################
# Check the environment and the region.
# Arguments:
#   Envionment and Region
#######################################
function check_env_region() {
    case "$1" in
        "prd")
            Envionment="prd"
            Profile="prd"
            export Envionment Profile
        ;;
        "stg")
            Envionment="stg"
            Profile="stg"
            export Envionment Profile
        ;;
        "dev")
            Envionment="dev"
            Profile="dev"
            export Envionment Profile
        ;;
        *)
            err "Check your environment in our setting $1"
            exit 1
        ;;
    esac
    case "$2" in
        "ap-northeast-1")
            Region="ap-northeast-1"
            export Region
        ;;
        "us-east-1")
            Region="us-east-1"
            export Region
        ;;
        "eu-west-1")
            Region="eu-west-1"
            export Region
        ;;
        *)
            err "Check your environment in our setting $2"
        ;;
    esac
}


#######################################
# Set parameters.
# Arguments:
#   parameter file path
#######################################
function set_parameters() {
    PARAMETER_FILE_PATH=$1
    PARAMETERS=$(cat "${PARAMETER_FILE_PATH}" | jq -r '.Parameters | to_entries |  map("\(.key)=\(.value)") | join(" ")')
    TAGS=$(cat "${PARAMETER_FILE_PATH}" | jq -r '.Tags | to_entries | map("\(.key)=\(.value)") | join(" ")')

    PARAMETERS_ARR=(${PARAMETERS//' '/ })
    for p in "${PARAMETERS_ARR[@]}";do
        export "$p"
    done

    printf "PARAMETERS:\t%s\n" "${PARAMETERS}"
    printf "TAGS: \t%s\n" "${TAGS}"
}

#######################################
# Set parameters about the environment and the region.
# Arguments:
#   Envionment and Region
#######################################
function set_parameters_by_env_region() {
    check_env_region "$@"

    if [ ! -f params/${Region}/${Envionment}.json ]; then
        err "no file: params/${Region}/${Envionment}.json"
        exit 1
    fi

    set_parameters params/${Region}/${Envionment}.json
}

#######################################
# deploy CloudFormation
# Arguments:
#   CloudFormation stack name
#######################################
function cloudformation_deploy() {
    echo "deploy $1"

    aws cloudformation deploy \
        --stack-name "$1" \
        --template-file "${TEMPLATE_FILE}" \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameter-overrides ${PARAMETERS} \
        --profile "${Profile}" \
        --region "${Region}" \
        --tags ${TAGS}
}

#######################################
# deploy CloudFormation simply
#######################################
function deploy() {
    if [ -z "$ApplicationName" ]; then
        err "Set ApplicationName"
        exit 1
    fi

    TEMPLATE_FILE="template.yaml"

    CLOUDFORMATION_STACK_NAME="${EnvironmentName}-${ApplicationName}"
    cloudformation_deploy $CLOUDFORMATION_STACK_NAME
}


#######################################
# check CloudFormation error reson
#######################################
function search_cloudformation_err() {
    err "$(aws cloudformation describe-stack-events --stack-name ${CLOUDFORMATION_STACK_NAME} | jq -r '.StackEvents[] | select(.ResourceStatus == "CREATE_FAILED") | .ResourceStatusReason')"
}