#!/bin/sh

for app in geth-base geth abigen bootnode;
do
    v_args=""
    if [[ ! -z "$1" ]]; then
        v_args="-t $app:$1 --build-arg GETH_VERSION=$1"
    fi
    docker build -t "${app}:latest" $v_args --force-rm -f "Dockerfile.${app}" .
    rc=$?
    if [[ $rc != 0 ]]; then
        exit $rc
    fi
done
