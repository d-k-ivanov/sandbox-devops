${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer inspect ${BUILDPATH}\image.json
