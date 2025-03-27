#!/bin/sh

# Environment Variables
## APP_NAME Application name
## ENV, specify environment parameters

# Script Parameters
## None

# Output
## None

# Script Purpose:
## Get pod information from k8s configuration file and use kubectl command to check health status after deployment


echo "> HEALTH CHECK $APP_NAME  begin"

if [[ ${ENV} == '' ]];
then
	echo "Please set ENV environment variable first"
	exit 1
fi

if [[ ${APP_NAME} == '' ]];
then
	echo ">> App name should be specified"
	exit 1
fi


K8S_FILE_PATH=${WORKSPACE}/devops/k8s/${APP_NAME}-${ENV}-runtime.yml
POD_NAME=`yq -r  '.metadata.name' ${K8S_FILE_PATH}  | tail -1`-0

echo ">> Probe if ${POD_NAME} is ready"
echo ">> Probe commnd : sudo kubectl get pod ${POD_NAME} -n ${ENV} -o custom-columns=NAME:.status.containerStatuses[0].ready | tail -1"

# check times
times=30
internal=10s

echo ">>> Sleep 60"
sleep 60

for (( i=0; i < times; i++ ));
  do
    echo ">>> Sleep ${internal}"
    sleep ${internal}
    echo ">>> K8s probe ${i} times"
    resultCode=`sudo kubectl get pod ${POD_NAME} -n ${ENV} -o custom-columns=NAME:.status.containerStatuses[0].ready | tail -1`
    if [[ $resultCode != "true" ]]; then
      continue
    else
      echo "> $APP_NAME healthcheck success!"
      exit 0
    fi
done

echo "> $APP_NAME healthcheck failed!"
exit 1
