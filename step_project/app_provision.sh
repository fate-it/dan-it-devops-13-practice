#!/bin/bash

APP_USER="petuser"
PROJECT_DIR="/home/${APP_USER}/petclinic"
APP_DIR="/home/${APP_USER}"
APP_SOURCE_DIR="${PROJECT_DIR}/forStep1/PetClinic"

sudo apt update
sudo apt install -y openjdk-17-jdk git


id -u ${APP_USER} &>/dev/null || useradd -m -s /bin/bash ${APP_USER}


if [ ! -d "${PROJECT_DIR}" ]; then
  sudo -u ${APP_USER} git clone https://gitlab.com/kuzmenkoserhii053/petclinicsource.git ${PROJECT_DIR}
fi

cd ${APP_SOURCE_DIR}
chmod +x mvnw

sudo -u ${APP_USER} ./mvnw clean package -DskipTests

JAR_FILE=$(ls target/*.jar | head -n 1)
cp ${JAR_FILE} ${APP_DIR}/petclinic.jar
chown ${APP_USER}:${APP_USER} ${APP_DIR}/petclinic.jar

sudo -u ${APP_USER} nohup java -jar ${APP_DIR}/petclinic.jar \
  --spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME} \
  --spring.datasource.username=${DB_USER} \
  --spring.datasource.password=${DB_PASS} \
  --server.port=8080 > ${APP_DIR}/app.log 2>&1 &
