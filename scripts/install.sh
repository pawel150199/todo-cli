#!/bin/bash

ARCH=$1 #arm64, amd64, darwin_amd64

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

URL="https://github.com/pawel150199/todo-cli/releases/download/20/todo_${ARCH}.zip"

mkdir -p /tmp/todo
cd /tmp/todo || exit 1
curl -L  -O ${URL}
unzip todo_${ARCH}.zip

ls -latrh 


mv todo_${ARCH} /bin/todo
chmod 755 /bin/todo

rm -rf /tmp/todo
