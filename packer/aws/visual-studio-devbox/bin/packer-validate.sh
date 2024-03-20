REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}/.." )" && pwd )"
packer validate ${REPO_ROOT}/aws-win-ami.json
