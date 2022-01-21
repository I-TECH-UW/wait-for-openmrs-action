#!/bin/bash


url=$1
interval=$2
timeout=$3

TIMEOUT_END=$(($(date +%s) + $timeout))


while :; do
    echo "Waiting for $1"

    response=$(curl -u admin:Admin123 -s -w "\n%{http_code}" $url/ws/fhir2/R4/metadata?_format=json)
    response=(${response[@]}) # convert to array
    code=${response[-1]} # get last element (last line)

    echo $code

    body=${response[@]::${#response[@]}-1} # get all elements except last

    if [[ "${body[0]}" == *"CapabilityStatement"* ]]; then
        echo "Got Metadata!"
        exit 0
    else
        echo "Still waiting..."
    fi

    if [ $(date +%s) -ge $TIMEOUT_END ]; then
      echo "Operation timed out!"
      exit 1
    fi

    sleep $interval
done