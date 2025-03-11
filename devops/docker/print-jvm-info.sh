#!/bin/sh

if [[ ${APP_NAME} == '' ]]; then
	echo "Please specify the environment variable 'APP_NAME' to dump JVM info."
	exit 1
fi

pid=$(ps -ef|grep java|grep -v 'grep'|grep -v 'init'|grep -v sh|awk -F " " '{print $1}')

if [[ $pid == '' ]]; then
	echo "No JVM instance found! Program exit now..."
	exit 1
fi

jvm_info=/tmp/jvm_info/

mkdir -p ${jvm_info}
rm -f /tmp/jvm_info/*
jmap -dump:format=b,file=${jvm_info}/${APP_NAME}.heap.dump ${pid} 
jstack $pid > ${jvm_info}/${APP_NAME}.jstack.log