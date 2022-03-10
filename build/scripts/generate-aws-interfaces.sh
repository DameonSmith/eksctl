#!/bin/bash -ex

[ "$#" -eq 2 ] || { echo "usage: ${0} <service-name> <interface-name>"; exit 1; }

SERVICE_NAME="${1}"
INTERFACE_NAME="${2}"

PACKAGE_NAME="github.com/aws/aws-sdk-go-v2/service/${SERVICE_NAME}"
AWS_SDK_DIR=$(go list -m -f '{{.Dir}}' "${PACKAGE_NAME}")

"${GOBIN}/ifacemaker" -f "${AWS_SDK_DIR}/*.go" -s Client -i "${INTERFACE_NAME}" -p awsapi -y "${INTERFACE_NAME} provides an interface to the AWS ${INTERFACE_NAME} service" | go run add_import.go "${PACKAGE_NAME}" > "../${SERVICE_NAME}.go"
