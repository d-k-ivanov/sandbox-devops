${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer validate ${BUILDPATH}\bamboo-windows-ami.json
