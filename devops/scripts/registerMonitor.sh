#!/bin/sh

# Environment variables:
# APP_NAME - Application name
# ENV - Environment (uat, sat, pre)

# Script purpose:
# Register the application's monitoring endpoint to the API gateway

echo "> REGISTER $APP_NAME MONITOR ENDPOINT in ${ENV} begin"

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

PARM_APP_NAME=${APP_NAME}-${ENV}
echo "PARM_APP_NAME=${PARM_APP_NAME}"

PARM_TARGET_VPC_IP=`/usr/sbin/ifconfig em2 | grep "inet" | grep "netmask" | awk '{print $2}'`
echo "PARM_TARGET_VPC_IP=${PARM_TARGET_VPC_IP}"

PORT_0_NAME=`sudo kubectl get svc ${PARM_APP_NAME} -n ${ENV} -o jsonpath='{.spec.ports[0].name}'`
if [[ ${PORT_0_NAME} == 'web' ]];
then
  PARM_TARGET_APP_PORT=`sudo kubectl get svc ${PARM_APP_NAME} -n ${ENV} -o jsonpath='{.spec.ports[0].nodePort}'`
else
  PARM_TARGET_APP_PORT=`sudo kubectl get svc ${PARM_APP_NAME} -n ${ENV} -o jsonpath='{.spec.ports[1].nodePort}'`
fi
echo "PARM_TARGET_APP_PORT=${PARM_TARGET_APP_PORT}"

# Application context path
APP_CONTEXT_PATH=${APP_NAME}

monitorUrl=http://${PARM_TARGET_VPC_IP}:${PARM_TARGET_APP_PORT}/${APP_CONTEXT_PATH}/monitoring

httpCode=`curl -l -s -w "%{http_code}\n" -o /dev/null -X GET ${monitorUrl}`

if [ $httpCode -ne 200 ]; then
  echo "Invalid monitoring endpoint: ${monitorUrl}"
	exit 1
fi

REGISTER_ENDPOINT=http://api-gateway-${ENV}.example.com/api/monitoring/register

echo ">> Start to register monitor endpoint in API gateway"

httpCode=`curl -l -s -w "%{http_code}\n" -o /dev/null -H "Content-Type: application/json" \
-d '{"appName":"'${PARM_APP_NAME}'","targetVpcIp":"'${PARM_TARGET_VPC_IP}'","targetAppPort":"'${PARM_TARGET_APP_PORT}'","appContextPath":"'${APP_NAME}'","monitoringPath":"monitoring","healthPath":"health","additionalTags":["'${ENV}'"]}' \
-X POST "${REGISTER_ENDPOINT}"`
echo "httpCode=$httpCode"

if [ $httpCode -eq 201 ]; then
  echo "Register successfully"
elif [ $httpCode -eq 409 ]; then
  echo "Monitoring endpoint has been existed already"
else
  echo "Unknown error: http response code is $httpCode"
  exit 1
fi

echo "> REGISTER $APP_NAME MONITOR ENDPOINT in ${ENV} end"
exit 0