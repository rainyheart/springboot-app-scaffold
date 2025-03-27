#!/bin/sh

# Environment Variables
## APP_NAME Application name
## JAR_FILE_NAME Built product jar

# Script Parameters
## None

# Output
## IMAGE_VERSION_FILE, used to store docker image version information
# > Contains image version information IMAGE_VERSION_NAME, e.g.: my-app-iam-pre:v18

# Script Purpose:
## Package into docker image


echo "> PACKAGE file begin"

if [[ ${JAR_FILE_NAME} == '' ]];
then
	echo ">> Jar file name should be specified"
	exit 1
fi

if [[ ${APP_NAME} == '' ]];
then
	echo ">> App name should be specified"
	exit 1
fi

if [[ ${IMAGE_VERSION_FILE} == '' ]];
then
	echo ">> IMAGE_VERSION_FILE should be specified"
	exit 1
fi

IMAGE_VERSION_NAME="${APP_NAME}-${ENV}:v${BUILD_NUMBER}"
if [[ ${IMAGE_VERSION_NAME} == '' ]];
then
	echo ">> Image version name should be specified"
	exit 1
fi

echo "$IMAGE_VERSION_NAME has been stored in $IMAGE_VERSION_FILE"
echo "$IMAGE_VERSION_NAME" > $IMAGE_VERSION_FILE

# no need to change, will be packaged for the docker image
FINAL_JAR_FILE_NAME=${JAR_FILE_NAME}

TARGET_PATH="$WORKSPACE/target"

echo ">> Copy files to docker folder for build"
cp $TARGET_PATH/$JAR_FILE_NAME $WORKSPACE/devops/docker/$FINAL_JAR_FILE_NAME

echo ">> Build docker image"
cd $WORKSPACE/devops/docker

docker build -t $IMAGE_VERSION_NAME \
--build-arg JAR_FILE_NAME=$FINAL_JAR_FILE_NAME \
--build-arg APP_NAME=${APP_NAME} \
.
echo "> Success package file begin"
