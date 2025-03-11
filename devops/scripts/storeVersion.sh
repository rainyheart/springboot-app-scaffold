#!/bin/sh

# 环境变量
## IMAGE_VERSION_FILE，这个是用于保存 docker image version 信息
##   > 里面保存了镜像的 version 信息 IMAGE_VERSION_NAME，比如：my-app-iam-pre:v18
## ENV，指定环境参数

# 脚本参数
## 无

# 结果输出
## 无

# 脚本作用：
## 用于保存镜像的版本到本地，用于给生产环境打包的时候，方便获取。
## > 以后有可能会打包到 git 仓库中，这样就不用专门去指定机器进行部署了。



echo "> STORE version into file"

echo ">> Ready to store $BUILD_NUMBER into file $HOME/imageVersion/${APP_NAME}/$ENV/verNum.${APP_NAME}"

mkdir -p $HOME/imageVersion/${APP_NAME}/$ENV
echo $BUILD_NUMBER > $HOME/imageVersion/${APP_NAME}/$ENV/verNum.${APP_NAME}


echo "> Success store version into file"
