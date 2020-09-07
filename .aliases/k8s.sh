alias kubectl=kubectl

alias pods='kubectl get pods -o wide'
alias nodes='kubectl get nodes -o wide'

alias kgp='kubectl get pods'
alias kgdp='kubectl get deployments'
alias kgcj='kubectl get cronjob'
alias kl='kubectl logs'
alias klf='kubectl logs -f'

function list_namespaces() {
	default_output='jsonpath={range .items[*]}{.metadata.name}{"\n"}'
	output_options=""${1:-$default_output}
	shift

	kubectl get namespace -o "${output_options}" $@ 
}

function current_namespace() {
	kubectl config view --output 'jsonpath={..namespace}'
}

function set_namespace() {
	wanted="$1"
	shift
	kubectl config set-context --current "--namespace=${wanted}" $@ > /dev/null
	current_namespace
}

function list_contexts() {
	kubectl config get-contexts
}

function current_context() {
	kubectl config current-context
}

function set_context() {
	set -e
	wanted="$1"
	shift
	kubectl config set current-context "${wanted}" $@ > /dev/null
	current_context
}


function ctx() {
	case "$*" in
		'') current_context;;
		list) list_contexts;;
		*) set_context "$*";;
	esac	
}

function ns() {
	# Usage: ns [namespace]
	#
	# No arguments: return the current namespace
	# Argument: sets the current namespace to the value supplied
	case "$*" in
        	'') current_namespace;;
	        list) list_namespaces;;
        	*) set_namespace "$*";;
	esac
}

# Usage <namespace>... [-- [OPTIONS]...]
# Example: logs_namespaces staging prod -- -lapp=myapp
function logs_namespaces() {
	namespaces=()
	while [[ "$1" != "--" && "$1" != "" ]]; do
		namespaces+=("$1")
		shift
	done
	shift

	for ns in ${namespaces[@]}; do
		set -x
		kubectl logs -n ${ns} $@
		set +x
	done
}

# Usage: [OPTIONS]...
# Example: logs_all_namespaces -lapp=myapp --since=2m --tail=10
function logs_all_namespaces() {
	IFS="
"
	for ns in $(list_namespaces); do
		printf '*** %-40s\n' "${ns}"
		kubectl logs -n "${ns}" $@
		printf '\n\n'
	done
}

