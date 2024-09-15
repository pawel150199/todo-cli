#!/bin/bash

curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.61.0 &> /dev/null

if [ $? == 0 ]; then
    echo "[INFO] [$(date)] installation has been sucessfuly done!"
    echo "[INFO] [$(date)] $(golangci-lint --version)"
    exit 0
else
   echo "[ERROR] [$(date)] installation has not been sucessfuly done! Try again"
   exit 1
fi


