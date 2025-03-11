#!/bin/sh

# 环境变量
## APP_NAME 应用的名字
## ENV，指定环境参数

# 脚本参数
## 无

# 结果输出
## 无

# 脚本作用：
## 从 k8s 配置文件中 获取到相应的 pod 的信息，使用 kubectl 的命令行 去检查部署后的健康情况


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
