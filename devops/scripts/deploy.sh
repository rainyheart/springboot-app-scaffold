#!/bin/sh

# 环境变量
## APP_NAME 应用的名字
## ENV，指定环境参数
## IMAGE_VERSION_FILE，这个是用于保存 docker image version 信息

# 脚本参数
## 无

# 结果输出
# 无

# 脚本作用：
## 获取到不同环境的k8s文件，同时进行部署，所有的部署的信息都集中在 k8s 中，本脚本不保存任何 app 信息和 部署流程中的任何参数

echo "> DEPLOY on the server"

if [[ $# -lt 1 ]]; then
    echo "usage: $0 <image version>"
    exit 1
fi

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

IMAGE_VERSION_NAME=$1
if [[ ${IMAGE_VERSION_NAME} == '' ]];
then
    echo ">> App image version name should be specified"
    exit 1
fi
echo ">> Image version name is $IMAGE_VERSION_NAME"

# public address 用于 RMI
#RMI_HOST=`curl http://ifconfig.me/ip`



# k8s 运行命令
echo "> Make runtime kubernates yaml file for ${APP_NAME}"

echo ">> Cp the runtime k8s yuml file"
export FROM_YML_FILE=${WORKSPACE}/devops/k8s/${APP_NAME}-${ENV}.yml
export TO_YML_FILE=${WORKSPACE}/devops/k8s/${APP_NAME}-${ENV}-runtime.yml
echo ">> Making runtime yml file from: ${FROM_YML_FILE}"
if [ -f ${TO_YML_FILE} ]; then    
    rm -f ${TO_YML_FILE}
fi
cp ${FROM_YML_FILE} ${TO_YML_FILE}
sed -i "s/\$IMAGE_VERSION_NAME/${IMAGE_VERSION_NAME}/g" ${TO_YML_FILE}
echo ">> ${TO_YML_FILE} is generated"


echo ">> Create a new k8s ${ENV} environment service ${APP_NAME}"
echo ">>> COMMAND: sudo kubectl apply -f ${TO_YML_FILE}"
sudo kubectl apply -f ${TO_YML_FILE}
