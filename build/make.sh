#!/bin/sh

V_TAG=""
V_ARG_ABIGEN=""
V_ARG_BOOTNODE=""
V_ARG_GETH=""

if [[ ! -z "$1" ]]; then
    V_TAG=$1
    V_ARG_ABIGEN="-t abigen:${V_TAG}" 
    V_ARG_BOOTNODE="-t bootnode:${V_TAG}"
    V_ARG_GETH="-t geth:${V_TAG}"
fi

if [ ! -d go-ethereum ]; then
    git clone git@github.com:ethereum/go-ethereum.git
fi

cd go-ethereum && git checkout master && git pull && git checkout $V_TAG && cd ..

docker build -t abigen:latest $V_ARG_ABIGEN --force-rm -f Dockerfile.abigen . \
    && docker build -t bootnode:latest $V_ARG_BOOTNODE -f Dockerfile.bootnode . \
    && docker build -t geth:latest $V_ARG_GETH -f Dockerfile.geth .
