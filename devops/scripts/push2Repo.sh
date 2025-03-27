#!/bin/sh

# Environment Variables
## IMAGE_VERSION_NAME, used to store docker image version information
##   > Contains image version information IMAGE_VERSION_NAME, e.g.: my-app-iam-pre:v18
## ENV, specify environment parameters

# Script Parameters
## None

# Output
## None

# Script Purpose:
## Push to private repository


echo "> PUSH IMAGE ${IMAGE_VERSION_NAME} begin"


if [[ ${ENV} == '' ]];
then
	echo "Please set ENV environment variable first"
	exit 1
fi

IMAGE_VERSION_NAME=`cat $IMAGE_VERSION_FILE`
if [[ ${IMAGE_VERSION_NAME} == '' ]];
then
	echo "Please set IMAGE_VERSION_NAME environment variable first"
	exit 1
fi
echo ">> Start to push image ${IMAGE_VERSION_NAME}"

DOCKER_REGISTRY=registry.example.com
DOCKER_REGISTRY_APP_IMAGE_NAME=${DOCKER_REGISTRY}/${IMAGE_VERSION_NAME}
sudo docker tag ${IMAGE_VERSION_NAME} ${DOCKER_REGISTRY_APP_IMAGE_NAME}
sudo docker push ${DOCKER_REGISTRY_APP_IMAGE_NAME}

echo "> Success push image ${DOCKER_REGISTRY_APP_IMAGE_NAME}"
exit 0
