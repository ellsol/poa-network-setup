#!/usr/bin/env bash

set -u
set -e


while getopts ":n:r:" opt; do
    case $opt in
        n) name="$OPTARG";;
        r) rpc_url="$OPTARG";;
    esac
done

if [[ ${name} == "" ]] ; then
  echo "no validator name provided"
  exit 0
fi


if [[ ${rpc_url} == "" ]] ; then
  echo "no rpc url provided"
  exit 0
fi

export RPC=${rpc_url}

directory=modules/poa-scripts-moc/generateInitialKey
node_modules=${directory}/node_modules


pushd ${directory}

if [ ! -d ${node_modules} ]; then
    npm i --production
fi


npm start
popd


if [ -d build/${name} ]; then
    rm -rf build/${name}
fi

mkdir build/${name}

mv ${directory}/output/*.key build/${name}/password.key
mv ${directory}/output/*.json build/${name}/wallet.json