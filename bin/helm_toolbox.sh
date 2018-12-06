#!/bin/bash

export TIMEOUT=3
export STDOUT=${STDOUT:-/dev/null}

RETRIES=${RETRIES:-5}
HELM_TILLER_REPLICA_COUNT=${HELM_TILLER_REPLICA_COUNT:-2}

# helper functions
function info() {
    echo -e "\e[32mINFO:\e[0m $1";
}

function err() {
    echo -e "\e[31mERROR:\e[0m $1" ;
    exit 1;
}

function check() {
    command -v "$1" >/dev/null 2>&1 || err "$1 not installed!";
}

function set_context() {
    if [ -n "$KUBE_CONTEXT" ]; then
        info "Using ${KUBE_CONTEXT} kube context"
        kubectl config use-context ${KUBE_CONTEXT}
    fi
}

function retry() {
    local attempt=0
    local limit=$1
    local command=${@:2}
    until [[ $attempt -ge $limit ]]
    do
        info "Perform attempt - $[$attempt+1]"
        $command && break
        attempt=$[$attempt+1]
        sleep $TIMEOUT
    done
}

function upsert() {
    local helm_version=$(helm version --client --short | grep -Eo "v[0-9]+\.[0-9]+\..+")
    local tiller_version=$(helm version --server --short --tiller-connection-timeout $TIMEOUT 2> /dev/null | grep -Eo "v[0-9]+\.[0-9]+\..+")
    if [ "$helm_version" != "$tiller_version" ]; then
        info "Helm version: $helm_version, differs with tiller version: ${tiller_version:-'not installed'}"
        info "Upgrading tiller to $helm_version"
        if [ $RBAC_ENABLED ]; then
            local tiller_serviceaccount=tiller
            local tiller_serviceaccount_exists=$(kubectl get serviceaccount -n kube-system --ignore-not-found=true --request-timeout=${TIMEOUT}s -o name $tiller_serviceaccount 2> /dev/null)
            local tiller_clusterrolebinding_exists=$(kubectl get clusterrolebinding --ignore-not-found=true --request-timeout=${TIMEOUT}s -o name tiller-cluster-rule 2> /dev/null)
            if [ -z "$tiller_serviceaccount_exists" ]; then
                kubectl create serviceaccount --namespace kube-system $tiller_serviceaccount > $STDOUT
            fi
            if [ -z $tiller_clusterrolebinding_exists ]; then
                kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:$tiller_serviceaccount > $STDOUT
            fi
            helm init --service-account $tiller_serviceaccount --upgrade --force-upgrade --wait --replicas $HELM_TILLER_REPLICA_COUNT > $STDOUT
        else
            helm init --upgrade --force-upgrade --wait --replicas $HELM_TILLER_REPLICA_COUNT > $STDOUT
        fi
        info "Helm version"
        helm version --short | sed 's/^/  - /'
    else
        info "Helm version: $helm_version matches tiller version: $tiller_version."
        info "Initializing helm client..."
        helm init --client-only > $STDOUT
    fi
}

if [ "$1" == "upsert" ]; then
    check kubectl
    check helm
    # check timeout
    set_context
    retry $RETRIES upsert
else
    err "Unknown command"
fi
