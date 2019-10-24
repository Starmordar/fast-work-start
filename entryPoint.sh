#!/bin/bash

echo -n "Username for 'http://example.com/': "
read username

echo -n "Password for 'http://${username}@example.com/': "
read -s password
echo ''


IP=$(curl -X GET -H "Content-type: application/json" -H "Accept: application/json" -d '{"name": "'${username}'", "password": "'${password}'"}' localhost:4000/getWorkspacesCurl)

echo $IP