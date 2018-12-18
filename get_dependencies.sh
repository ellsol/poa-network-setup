#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]
  then
    echo "no network name supplied"
    exit 1
fi


mkdir -p build/keys/moc
mkdir modules
pushd modules

git clone https://github.com/poanetwork/poa-network-consensus-contracts
git clone https://github.com/poanetwork/poa-chain-spec
git clone https://github.com/poanetwork/solidity-flattener
git clone https://github.com/poanetwork/poa-scripts-moc
git clone https://github.com/poanetwork/poa-dapps-validators
git clone https://github.com/poanetwork/poa-dapps-voting
git clone https://github.com/poanetwork/poa-dapps-keys-generation

# flatten contracts
pushd poa-network-consensus-contracts
npm install
./make_flat.sh
popd

# prepare poa chain spec
pushd poa-chain-spec
git checkout --track origin/sokol
git checkout -b $1
cp spec.json ../../build/spec.json
popd

popd