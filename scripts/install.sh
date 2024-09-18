#!/bin/bash

ARCH=$1 #arm64, amd64, darwin_amd64
URL="https://github.com/pawel150199/todo-cli/releases/download/21/todo_${ARCH}.zip"

info() {
    echo "[$(date)][INFO] $@"
}

error() {
    echo "[$(date)][ERROR] $@"
}

if [[ ${ARCH} != "arm64" &&  ${ARCH} != "amd64" && ${ARCH} != "darwin_amd64" ]];then
    info "The architecture is not supported. Choose one of them: arm64, amd64, darwin_amd64"
fi

if [ $# != "1" ];then
    info "$#"
    error "Not enough parameters. Please add ARCH variable as a parameter"
fi

mkdir -p /tmp/todo
cd /tmp/todo || exit 1
curl -Ls  -O ${URL}
unzip todo_${ARCH}.zip
mv ./todo_${ARCH} ./todo
ls -latrh 
cp ./todo /usr/local/bin/todo
chmod 755 /usr/local/bin/todo

rm -rf /tmp/todo /tmp/todo_${ARCH}.zip
