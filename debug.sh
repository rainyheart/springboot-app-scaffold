#!/bin/sh

# 如果DNS服务器有改动，测添加进去/etc/resolv.conf
echo "nameserver 183.60.83.19" >> /etc/resolv.conf
echo "nameserver 183.60.82.98" >> /etc/resolv.conf

# 方案1. 如果是使用devops-app.tencentcloudcr.com/app-baseline/app-baseline-javaspring4dev:v1镜像，则用这个启动方法：
# java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9394 -jar ./my-app-iam/target/my-app-iam-exec.jar

# 方案2. 如果是使用maven:3.6.3-jdk-8镜像，则使用这个方法
mvn spring-boot:run -f ./pom.xml -s ./settings.xml

# 方案3. 如果需要先编译再启动，则使用这个方法，注意是使用maven:3.6.3-jdk-8镜像
# mvn install -s ./settings.xml -e -Dmaven.test.skip=true -f ./pom.xml && mvn spring-boot:run -f ./pom.xml -s ./settings.xml