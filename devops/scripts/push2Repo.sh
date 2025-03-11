#!/bin/sh

# 环境变量
## IMAGE_VERSION_NAME，这个是用于保存 docker image version 信息
##   > 里面保存了镜像的 version 信息 IMAGE_VERSION_NAME，比如：my-app-iam-pre:v18
## ENV，指定环境参数

# 脚本参数
## 无

# 结果输出
## 无

# 脚本作用：
## 推送到私有仓库


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
