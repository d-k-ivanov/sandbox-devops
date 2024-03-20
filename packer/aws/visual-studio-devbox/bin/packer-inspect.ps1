$REPO_ROOT = (get-item $PSScriptRoot).parent.FullName
packer inspect ${REPO_ROOT}\aws-win-ami.json
