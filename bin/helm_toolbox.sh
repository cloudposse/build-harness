#!/bin/bash

export TIMEOUT=3
export STDOUT=${STDOUT:-/dev/null}

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

# wait for helm to become operational
wait_for_helm() {
	info "Waiting for helm tiller..."
	while true; do
    status=$(echo $(kubectl get pods -l app=helm -l name=tiller --show-all=false -o=custom-columns=STATUS:.status.phase --no-headers=true -nkube-system))
		info "Helm status: $status"
		if [ "$status" = "Running" ]; then
			break;
		fi
		sleep $TIMEOUT
	done
}

function set_context() {
  if [ -n "$KUBE_CONTEXT" ]; then
	info "Using ${KUBE_CONTEXT} kube context"
	kubectl config use-context ${KUBE_CONTEXT}
  fi
}

function upsert() {
	helm_version=$(helm version --client --short | grep -Eo "v[0-9]\.[0-9]\.[0-9]")
	tiller_version=$(timeout $TIMEOUT helm version --server --short | grep -Eo "v[0-9]\.[0-9]\.[0-9]")

    if [ -z "$tiller_version" ]; then
      err "Unable to connect to helm server"
    fi

	if [ "$helm_version" != "$tiller_version" ]; then
		info "Helm version: $helm_version, differs with tiller version: $tiller_version"
		info "Upgrarding tiller to $helm_version"
		helm init --upgrade --force-upgrade > $STDOUT
		wait_for_helm
		sleep 3
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
	upsert
else
	err "Unknown commmand"
fi
