$REPO_ROOT = (get-item $PSScriptRoot).parent.FullName
packer validate ${REPO_ROOT}\aws-win-ami.json
