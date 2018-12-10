#!/usr/bin/env bash


while getopts ":m:c:r:" opt; do
    case $opt in
        c) consensus="$OPTARG";;
        m) moc_address="$OPTARG";;
        r) rpc_url="$OPTARG";;
    esac
done

if [[ ${moc_address} == "" ]] ; then
  echo "no moc address provided"
  exit 0
fi

if [[ ${consensus} == "" ]] ; then
  echo "no consensus address provided"
  exit 0
fi

if [[ ${rpc_url} == "" ]] ; then
  echo "no rpc url provided"
  exit 0
fi



pushd modules/poa-network-consensus-contracts

DEMO=true
SAVE_TO_FILE=true
POA_NETWORK_CONSENSUS_ADDRESS=${consensus}
MASTER_OF_CEREMONY=${moc_address}
./node_modules/.bin/truffle migrate --network ${rpc_url}

popd