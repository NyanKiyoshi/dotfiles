alias docker=docker

# Run a given command in a passed docker image.
# Usage: drun <image tag> <command...>
drun() {
	image=$1
	shift
	context=$(mktemp -d)
	docker build -t "${image}" -f - "${context}" << EOF
FROM ${image}
RUN $@
EOF
}

alias dsig='docker kill -s'
alias dkill='docker kill -s SIGQUIT'
alias dps='docker ps'
alias dpsa='dps -a'
alias dexec='docker exec -ti'

