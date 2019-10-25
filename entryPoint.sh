#!/bin/bash

# echo -n "Username for 'http://example.com/': "
# read username

# echo -n "Password for 'http://${username}@example.com/': "
# read -s password
# echo ''

IP=$(
    curl --silent -X GET \
        -H "Content-type: application/json" \
        -H "Accept: application/json" \
        -d '{"name": "Starmordar", "password": "Msims7529"}' \
        localhost:4000/getWorkspacesCurl
)

mapfile -t lines <<<$(jq '.[].category' <<<$IP)

IFS=' ' read -ra my_array <<<"$lines"

sorted_unique_ids=($(echo "${lines[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo "Input on of the available workspaces: "
for i in "${sorted_unique_ids[@]}"; do
    echo "${i//\"/}"
done

read category

returnNameFromCategory() {
    local category=$1
    shift
    local arr=("$@")

    local flag=1
    for i in "${sorted_unique_ids[@]}"; do
        if [ "${i//\"/}" = "$category" ]; then

            mapfile -t lines2 <<<$(jq -r '.[] | select(.category=="'${category}'") | .name' <<<$IP)

            flag=0
        fi
    done

    return $flag
}

returnNameFromCategory $category "${sorted_unique_ids[@]}"

categoryFlag=$?

while [[ $categoryFlag -eq 1 ]]; do
    echo -n "Enter correct name of category: "
    read category

    returnNameFromCategory $category "${sorted_unique_ids[@]}"

    categoryFlag=$?
done

prepareWorkspaceToOpenOnUserSystem() {
    local name=$1
    shift
    local category=$1
    shift
    local arr=("$@")

    local flag=1
    for i in "${my_array[@]}"; do
        if [ "${i//\"/}" = "$name" ]; then

            mapfile -t lines3 <<<$(jq -r '.[] | select((.category=="'${category}'") and .name=="'${name}'") | .technologies' <<<$IP)

            flag=0
        fi
    done

    return $flag
}

IFS=' ' read -ra my_array <<<"$lines2"

echo "Input name of the available workspaces: "
for i in "${my_array[@]}"; do
    echo "${i//\"/}"
done

read name

prepareWorkspaceToOpenOnUserSystem $name $category "${lines2[@]}"

nameFlag=$?

while [[ $nameFlag -eq 1 ]]; do
    echo -n "Enter correct name of workspace: "
    read name

    prepareWorkspaceToOpenOnUserSystem $name "${my_array[@]}"

    nameFlag=$?
done

echo $lines3
