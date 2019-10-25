#!/bin/bash

source "./helper/_helper.sh"
source "./helper/_constant.sh"

echo -n "Username for 'http://example.com/': "
read username

echo -n "Password for 'http://${username}@example.com/': "
read -s password
echo ''

IP=$(
    curl --silent -X GET \
        -H "Content-type: application/json" \
        -H "Accept: application/json" \
        -d '{"name": "'${username}'", "password": "'${password}'"}' \
        localhost:4000/getWorkspacesCurl
)

if [ "$IP" = "$ERROR_CANNOT_MATCH_PASSWORD" ] ||
    [ "$IP" = "$ERROR_CANNOT_FINT_USER_BY_USERNAME" ]; then
    echo $IP
    exit
fi

mapfile -t categoriesString <<<$(jq '.[].category' <<<$IP)
IFS=' ' read -ra categoriesArray <<<"$categoriesString"
uniquesCategories=($(echo "${categoriesString[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

for i in "${uniquesCategories[@]}"; do
    echo "${i//\"/}"
done

echo -n "Input one of the available workspaces: "
read category

getWorkspacesNameBelongingToThisCategory $category "${uniquesCategories[@]}"
categoryFlag=$?

while [[ $categoryFlag -eq 1 ]]; do
    echo -n "Enter correct name of category: "
    read category

    getWorkspacesNameBelongingToThisCategory $category "${uniquesCategories[@]}"
    categoryFlag=$?
done

IFS=' ' read -ra technologiesArray <<<"$names"

for i in "${technologiesArray[@]}"; do
    echo "${i//\"/}"
done

echo "Input name of the available workspaces: "
read name

getWorkspaceTechnologiesWithParticularName $name $category "${names[@]}"
nameFlag=$?

while [[ $nameFlag -eq 1 ]]; do
    echo -n "Enter correct name of workspace: "
    read name

    getWorkspaceTechnologiesWithParticularName $name $category "${technologiesArray[@]}"
    nameFlag=$?
done

echo $technologies
