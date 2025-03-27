#!/bin/sh

# Environment Variables
## IMAGE_VERSION_FILE, used to store docker image version information
##   > Contains image version information IMAGE_VERSION_NAME, e.g.: my-app-iam-pre:v18
## ENV, specify environment parameters

# Script Parameters
## None

# Output
## None

# Script Purpose:
## Used to save image version locally, convenient for production environment packaging.
## > May be packaged into git repository in the future, eliminating the need for deployment on specific machines.



echo "> STORE version into file"

echo ">> Ready to store $BUILD_NUMBER into file $HOME/imageVersion/${APP_NAME}/$ENV/verNum.${APP_NAME}"

mkdir -p $HOME/imageVersion/${APP_NAME}/$ENV
echo $BUILD_NUMBER > $HOME/imageVersion/${APP_NAME}/$ENV/verNum.${APP_NAME}


echo "> Success store version into file"
