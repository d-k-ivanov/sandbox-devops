${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer validate ${BUILDPATH}\image.json
