#!/usr/local/bin/bash

url=${1:-"http://isanteplus:8080/openmrs"}
interval=${2:-10}
timeout=${3:-100}

START_TIME=$(date +%s)
TIMEOUT_END=$(($START_TIME + $timeout))


while :; do
    echo "Waiting for $url"

    # TODO: take out redundant approach
    fhir=0
    rest=0

    if [ $fhir -eq 0 ]; then
        response=$(curl --max-time 1 -u admin:Admin123 -s -w "\n%{http_code}" $url/ws/fhir2/R4/metadata?_format=json)
        response=(${response[@]}) # convert to array
        code=${response[-1]} # get last element (last line)

        echo "Response Code: $code"

        body=${response[@]::${#response[@]}-1} # get all elements except last

        if [[ "${body[0]}" == *"CapabilityStatement"* ]]; then
            echo "Got FHIR Metadata after $(($(date +%s)-$START_TIME)) seconds!"
            fhir=1
        fi
    fi

    if [ $rest -eq 0 ]; then
        response=$(curl --max-time 1 -u admin:Admin123 -s -w "\n%{http_code}" $url/ws/rest/v1/session)
        response=(${response[@]}) # convert to array

        code=${response[-1]} # get last element (last line)

        echo "Response Code: $code"

        if [[ "$code" == "200" ]]; then
            echo "Got REST API after $(($(date +%s)-$START_TIME)) seconds!"
            rest=1        
        fi
    fi

    if [[ $rest -eq 1 && $fhir -eq 1 ]]; then 
        echo "Exiting!"
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