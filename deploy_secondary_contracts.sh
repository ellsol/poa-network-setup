#!/usr/bin/env bash


while getopts ":m:c:r:" opt; do
    case $opt in
        c) consensus="$OPTARG";;
        m) moc_address="$OPTARG";;
        n) network_name="$OPTARG";;
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

if [[ ${network_name} == "" ]] ; then
  echo "no network name provided"
  exit 0
fi



pushd modules/poa-network-consensus-contracts

SAVE_TO_FILE=true
POA_NETWORK_CONSENSUS_ADDRESS=${consensus}
MASTER_OF_CEREMONY=${moc_address}
./node_modules/.bin/truffle migrate --network ${network_name}

popd