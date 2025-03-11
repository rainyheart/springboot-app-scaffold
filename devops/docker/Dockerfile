FROM registry.cn-shenzhen.aliyuncs.com/devops-app/app-baseline-javaspring4app:v1

# 设置参数
ARG  JAR_FILE_NAME
ARG  APP_NAME

# Label 打上你的 Mark头
LABEL maintainer "Spring Boot App Scaffold DOCKER FILE"

# 设置工作区
ENV VM_PROJECT_DIR=/usr/local/springboot
WORKDIR $VM_PROJECT_DIR

RUN mkdir -p /opt/app/devops/
COPY print-jvm-info.sh /opt/app/devops/print-jvm-info.sh
RUN chmod 744 /opt/app/devops/print-jvm-info.sh

# 设置环境变量
# 目录一定要以/结尾
ENV CLASSPATH=/tmp/
ENV RMI_PORT=0
ENV RMI_HOST=0.0.0.0
ENV APP_NAME ${APP_NAME:-UNKNOWN_APP}
ENV JAR_FILE_NAME ${JAR_FILE_NAME:-UNKNOWN_JAR}
ENV JAVA_XMX=500m
ENV JAVA_XMS=500m
ENV JAVA_OPTS=""

# 复制文件到工作区中
COPY $JAR_FILE_NAME $VM_PROJECT_DIR/$JAR_FILE_NAME

# springboot 2.0.9 新增 spring.config.additional-location 代替 spring.config.location
# spring.config.location 会直接覆盖原来classpath的配置文件路径，所以必须jar里面的配置文件不生效
CMD java -Xmx${JAVA_XMX} -Xms${JAVA_XMS} ${JAVA_OPTS} \
	-Dcom.sun.management.jmxremote=true \
	-Dcom.sun.management.jmxremote.rmi.port=${RMI_PORT} \
	-Dcom.sun.management.jmxremote.port=${RMI_PORT} \
	-Dcom.sun.management.jmxremote.authenticate=false \
	-Dcom.sun.management.jmxremote.ssl=false \
	-Dcom.sun.management.jmxremote.local.only=false \
	-Djava.rmi.server.hostname=${RMI_HOST} \
    -Dapp.name=${APP_NAME} \
	-cp ${CLASSPATH} \
	-jar ./${JAR_FILE_NAME} --spring.config.additional-location=${CLASSPATH}