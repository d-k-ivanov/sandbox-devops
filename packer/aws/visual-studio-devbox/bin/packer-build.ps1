$REPO_ROOT = (get-item $PSScriptRoot).parent.FullName
packer build $args ${REPO_ROOT}\aws-win-ami.json
