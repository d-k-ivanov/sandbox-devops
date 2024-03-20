${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer inspect ${BUILDPATH}\bamboo-windows-ami.json
