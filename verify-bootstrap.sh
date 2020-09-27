#!/bin/bash
BOOTSTRAP_POLLING_INTERVAL=30
RETRY_INTERVAL=5
while true;
do
    response=$(curl -s -X POST --data '{
        "jsonrpc":"2.0",
        "id"     :1,
        "method" :"info.isBootstrapped",
        "params": {
            "chain":"X"
        }
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info)
    if [ $? -ne 0 ]
    then
        if [ -z $server_online_header_printed ]
        then
            echo "Waiting for node to come online." 
            server_online_header_printed=true
        else
            printf "."
        fi
        sleep $RETRY_INTERVAL
        continue
    fi

    echo $response | jq -e '.result.isBootstrapped == true' > /dev/null
    if [ $? -eq 0 ]
    then
        echo "Your node is up and running!"
        exit
    elif [ -z $header_printed ]
    then
        echo "Bootstrapping... This may take a while. Polling every $BOOTSTRAP_POLLING_INTERVAL seconds"
        header_printed=true
    else
        printf "."
        sleep $BOOTSTRAP_POLLING_INTERVAL
    fi

done
