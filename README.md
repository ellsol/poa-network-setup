# How To Deploy a POA Network


## Get POA dependencies

        ./get_dependencies.sh

## Prepare Master Of Ceremony

1. Create an ethereum address with your favorite method. This will result in


        MOC_ADDRESS="public key"
    
        KEYFILE="UTC.....json"
    
        PASSWORD=YOUR CHOICE
    
        mv <KEYFILE> > build/keys/moc
    
        echo {PASSWORD} > build/keys/moc/password.txt
     

3. Compile contract with address
     
       ./compile_contract_code_with_moc_address.sh {MOC_ADDRESS}
       
4. Extract contract bin from build/poa_contract.bin. In the following called CONTRACT_BIN.  

## Prepare spec.json
 
1. Create address CONTRACT_ADDRESS for poa contract address. Only the public key is from interest. 

2. Choose NETWORK_NAME and NETWORK_ID as hex and in build/spec.json add 

   
        name={NETWORK_NAME}
        params.NetworkID={NETWORK_ID}
   
   
3. In build/spec.json replace former contract key with 


        "{CONTRACT_KEY}": {
          "balance":"1",
          "constructor": "{CONTRACT_BIN}"
        }

4. Change address in spec accounts with a lot of ether to {MOC_ADDRESS}

5. Inside engine.authorityRound.params.validators.multi remove values other than 0. The final result should look like

    
        "validators": {
            "multi": {
                "0": {
                     "safeContract": "{CONTRACT_ADDRESS}"
                }
            }
            ...
        }

## Create Parity Node

1. Create a parity node with a config directory {CONFIG_DIR}. Write down IP as {RPC_URL_OF_PARITY_NODE}
2. Copy keys build/keys/moc/KEYFILE to {CONFIG_DIR}/keys/NETWORK_NAME
3. Copy build/keys/moc/password.txt into {CONFIG_DIR}
4. Copy build/spec.json into {CONFIG_DIR}
5. Fill out placeholders in config.toml.plain and copy to {CONFIG_DIR}
6. Start Node with

    
        parity --config {CONFIG_DIR}/config.toml              
             
## Deploy Secondary Contracts

1. Add to file modules/poa-network.../truffle.js

    
        NETWORK_NAME: {
              host: "{RPC_URL_OF_PARITY_NODE}",
              port: 8545,
              gas: 6400000,
              network_id: "*" // Match any network id
        },             
   
2. In migrations/2_deploy_contract.js change

        
        if (network === 'sokol') ...

to
     
        if (network === NETWORK_NAME) ...
        
        
3. Execute

    
        ./deploy_secondary_contracts.sh -m {MOC_ADDRESS} -c {CONSENSUS_ADDRESS} -r {RPC_URL_OF_PARITY_NODE}
        
4. Result


        => contracts.json 
    
## Add Validator

1. Clone git@github.com:lukso-network/lukso-dapps-keys-generation.git

2.

3. Create initial key for validator VALIDATOR_NAME

        ./create_initial_key.sh -r RPC_URL_OF_PARITY_NODE -n VALIDATOR_NAME
        


 