getWorkspacesNameBelongingToThisCategory() {
    local category=$1
    shift
    local categories=("$@")

    local flag=1
    for i in "${categories[@]}"; do
        if [ "${i//\"/}" = "$category" ]; then
            mapfile -t names <<<$(jq -r '.[] | 
                    select(.category=="'${category}'") | 
                    .name' <<<$IP)
            flag=0
        fi
    done

    return $flag
}

getWorkspaceTechnologiesWithParticularName() {
    local name=$1
    shift
    local category=$1
    shift
    local names=("$@")

    local flag=1
    for i in "${names[@]}"; do
        if [ "${i//\"/}" = "$name" ]; then
            mapfile -t technologies <<<$(jq -r '.[] | 
                    select((.category=="'${category}'") and .name=="'${name}'") | 
                    .technologies' <<<$IP)
            flag=0
        fi
    done

    return $flag
}
