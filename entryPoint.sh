#!/bin/bash

# echo -n "Username for 'http://example.com/': "
# read username

# echo -n "Password for 'http://${username}@example.com/': "
# read -s password
# echo ''

IP=$(
    curl -X GET \
        -H "Content-type: application/json" \
        -H "Accept: application/json" \
        -d '{"name": "Starmordar", "password": "Msims7529"}' \
        localhost:4000/getWorkspacesCurl
)

mapfile -t lines <<< $(jq '.[].category' <<<  $IP)

echo ${lines}

IFS=' ' read -ra my_array <<< "$lines"

sorted_unique_ids=($(echo "${lines[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

for i in "${sorted_unique_ids[@]}"
do
    echo $i
done