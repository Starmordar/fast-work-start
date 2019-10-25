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

mapfile -t categoriesString <<<$(jq '.[].category' <<<$IP)

IFS=' ' read -ra categoriesArray <<<"$categoriesString"

uniquesCategories=($(echo "${categoriesString[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

for i in "${uniquesCategories[@]}"; do
    echo "${i//\"/}"
done

echo -n "Input on of the available workspaces: "
read category

getWorkspacesNameBelongingToThisCategory() {
    local category=$1
    shift
    local categories=("$@")

    local flag=1
    for i in "${categories[@]}"; do
        if [ "${i//\"/}" = "$category" ]; then
            mapfile -t names <<<$(jq -r '.[] | \
                    select(.category=="'${category}'") | \
                    .name' <<<$IP)
            flag=0
        fi
    done

    return $flag
}

getWorkspacesNameBelongingToThisCategory $category "${uniquesCategories[@]}"

categoryFlag=$?

while [[ $categoryFlag -eq 1 ]]; do
    echo -n "Enter correct name of category: "
    read category

    getWorkspacesNameBelongingToThisCategory $category "${uniquesCategories[@]}"

    categoryFlag=$?
done

getWorkspaceTechnologiesWithParticularName() {
    local name=$1
    shift
    local category=$1
    shift
    local names=("$@")

    local flag=1
    for i in "${names[@]}"; do
        if [ "${i//\"/}" = "$name" ]; then
            mapfile -t technologies <<<$(jq -r '.[] | \
                    select((.category=="'${category}'") and .name=="'${name}'") | \
                    .technologies' <<<$IP)
            flag=0
        fi
    done

    return $flag
}

IFS=' ' read -ra technologiesArray <<<"$names"

echo "Input name of the available workspaces: "
for i in "${technologiesArray[@]}"; do
    echo "${i//\"/}"
done

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
