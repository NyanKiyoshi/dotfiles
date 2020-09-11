GIT_ROOT_DIR="${GIT_ROOT_DIR:-$HOME/pkg/src}"

# Usage: [DIRS]...
function cdgit() {
	local IFS='/'
	cd "$GIT_ROOT_DIR"/"$*"
}

alias github="cdgit github.com"
alias nyan="github NyanKiyoshi"
alias mirumee="github Mirumee"

