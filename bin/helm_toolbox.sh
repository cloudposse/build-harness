#!/bin/bash

export TIMEOUT=3
export STDOUT=${STDOUT:-/dev/null}

RETRIES=5

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
  attempt=1
  until [[ $n -ge $2 ]]
  do
	info "Perform attempt - $attempt"
    $1 && break
    n=$[$attempt]
    sleep 15
  done
}

function upsert() {
	helm_version=$(helm version --client --short | grep -Eo "v[0-9]\.[0-9]\.[0-9]")
	tiller_version=$(timeout $TIMEOUT helm version --server --short | grep -Eo "v[0-9]\.[0-9]\.[0-9]")

	if [ "$helm_version" != "$tiller_version" ]; then
		info "Helm version: $helm_version, differs with tiller version: ${tiller_version:-'not installed'}"
		info "Upgrarding tiller to $helm_version"
		helm init --upgrade --force-upgrade --wait > $STDOUT
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
	check timeout
	set_context
	retry upsert $RETRIES
else
	err "Unknown commmand"
fi
