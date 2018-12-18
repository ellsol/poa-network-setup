#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "no moc address supplied"
    exit 1
fi

pushd modules/poa-network-consensus-contracts/scripts
    npm install
    MASTER_OF_CEREMONY=$1 node poa-bytecode.js > ../../../build/poa_contract.bin
popd

