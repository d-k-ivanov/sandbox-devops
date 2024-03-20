${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer build ${BUILDPATH}\bamboo-windows-ami.json
