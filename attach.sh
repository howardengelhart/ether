#!/bin/bash
# Run GETH and attach to node using the web rpc
# use --exec "js" to run a command and exit
#
# This gets the current balance in eth for the coinbase account
# If the network is fully up and running this should work against node1 or node2
# ./attach.sh node1 --exec "web3.fromWei(eth.getBalance('5fe2ebc7cc54560d7d88681f8277c91b57c7362a'),'ether')"

# This gets the nodes peers, note, only node2 is configured to run the admin api via web rpc
# ./attach.sh node2 --exec "admin.peers"

NODE_IP="10.5.0.6"
CMD=""

case $1 in 
node1)
    NODE_IP="10.5.0.5"
    ;;
node2)
    NODE_IP="10.5.0.6"
    ;;
--*)
    CMD="$1 $2"
    ;;
esac

case $2 in 
--*)
    CMD="$2 $3"
    ;;
esac

docker run --rm --network ether_ether -it zepp0/geth attach "http://${NODE_IP}:8545" $CMD
